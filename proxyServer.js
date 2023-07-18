const https = require('https');
const httpProxy = require('http-proxy');
const fs = require('fs');
const url = require('url');
const zlib = require('zlib');
const { getImgurData, assembleResponse } = require('./imgurHandler');


let clientRedirectUri = 'apollo://oauth';

function startProxyServer(port) {
    const allowedHosts = ['www.reddit.com', 'oauth.reddit.com', 'apollogur.download'];

    const options = {
        target: 'http://localhost/',
        changeOrigin: true,
        ws: true,
        ssl: {
            key: fs.readFileSync('certificates/reddit.key', 'utf8'),
            cert: fs.readFileSync('certificates/fullchain.crt', 'utf8'),
        }
    };

    const proxy = httpProxy.createProxyServer(options);

    proxy.on('proxyReq', function(proxyReq, req) {
        const reqUrl = new url.URL(req.url, `https://${req.headers.host}`);
        proxyReq.setHeader('host', req.headers.host);

        let modifiedRequest = false;

        const userAgent = req.headers['user-agent'];
        const shouldChangeUserAgent = !(userAgent.includes('Mozilla') 
                                        && !userAgent.includes('iPhone') 
                                        && !userAgent.includes('iPad') 
                                        && !userAgent.includes('Android'));

        if (shouldChangeUserAgent) {
            modifiedRequest = true;
            //proxyReq.setHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0');
            proxyReq.setHeader('User-Agent', process.env.CLIENT_ID);
        }

        if (reqUrl.pathname === '/api/v1/access_token') {
            modifiedRequest = true;
            proxyReq.setHeader('authorization', 'Basic ' + Buffer.from(process.env.CLIENT_ID + ':').toString('base64'));
        }

        console.log(new Date(), modifiedRequest ? "proxy > *" : "proxy >", req.method, req.url);
    });

    proxy.on('proxyRes', function(proxyRes, req, res) {
        console.log(new Date(), "proxy <", proxyRes.statusCode, req.url);
        const reqUrl = new url.URL(req.url, `https://${req.headers.host}`);
    
        if ((reqUrl.pathname === '/svc/shreddit/oauth-grant' || reqUrl.pathname === '/api/v1/authorize')&& proxyRes.statusCode === 302) {
            proxyRes.pipe = function() {};
            
            const locationUrl = new url.URL(proxyRes.headers.location);

            if (clientRedirectUri) {
                const parsedClientRedirectUri = url.parse(clientRedirectUri);
    
                locationUrl.protocol = parsedClientRedirectUri.protocol;
                locationUrl.hostname = parsedClientRedirectUri.hostname;
    
                let body = Buffer.from([]);
    
                proxyRes.on('data', function(data) {
                    body = Buffer.concat([body, data]);
                });
    
                proxyRes.on('end', function() {
                    let headers = {
                        ...proxyRes.headers,
                        'Location': locationUrl.toString()+"#_"
                    };
                    
                    res.writeHead(proxyRes.statusCode, headers);
    
                    res.write(body);
                    res.end();
                });
            } else {
                console.error('clientRedirectUri is not set!');
            }
        }
    });

    const httpsServer = https.createServer({
        key: fs.readFileSync('certificates/reddit.key'),
        cert: fs.readFileSync('certificates/fullchain.crt'),
    }, async (req, res) => {
        const reqUrl = new url.URL(req.url, `https://${req.headers.host}`);
        const isAccessTokenRequest = reqUrl.pathname === '/api/v1/access_token';

        if (!req.headers.host || !allowedHosts.includes(req.headers.host)) {
            res.writeHead(403, { 'Content-Type': 'text/plain' });
            res.end(`Host ${req.headers.host} is not allowed`);
            console.log(new Date(), "proxy 🚫 ", req.method, req.url);

        } else if (req.headers.host === 'apollogur.download') {

            if(reqUrl.pathname.startsWith('/check')) {
               
                // Allow all access control
                res.setHeader('Access-Control-Allow-Origin', '*');
                res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');

                res.writeHead(200, { 'Content-Type': 'text/plain' });
                res.end('OK');

            } else if(reqUrl.pathname.startsWith('/api/image/')) {
                console.log(new Date(), "imgur >", req.method, req.url);

                const imageId = reqUrl.pathname.split('/')[3];
                try {
                    const imgurData = await getImgurData(imageId);
                    const response = assembleResponse(imgurData);
                    res.writeHead(200, { 'Content-Type': 'application/json' });
                    res.end(response);
                } catch (error) {
                    console.log(new Date(), "imgur", imageId, "Failed to retrieve metadata");
                    res.writeHead(404, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ "data": { "error": "Unable to retrieve image" }, "success": false, "status": 404 }));
                }
            } else {
                // Return 404 to client
                res.writeHead(404, { 'Content-Type': 'text/plain' });
                res.end(`Endpoint not implemented`);
            }
        
            
        } else if (reqUrl.pathname === '/api/v1/authorize' && req.method === "GET" && reqUrl.searchParams.get('client_id') !== process.env.CLIENT_ID) {
            console.log(new Date(), "proxy", req.method, "intercepted request with client_id:", reqUrl.searchParams.get('client_id'));
            console.log(new Date(), "proxy", req.method, "intercepted request with redirect_uri:", reqUrl.searchParams.get('redirect_uri'));

            clientRedirectUri = reqUrl.searchParams.get('redirect_uri');

            reqUrl.searchParams.set('client_id', process.env.CLIENT_ID);
            reqUrl.searchParams.set('redirect_uri', process.env.REDIRECT_URI); //.replace(/:/g, '%3A'));

            //console.log(process.env.CLIENT_ID, process.env.REDIRECT_URI.replace(/:/g, '%3A'));

            res.writeHead(302, { Location: reqUrl.toString() });
            res.end();
        } else if (reqUrl.pathname === '/api/v1/access_token' && req.method === 'POST') {
            let bodyChunks = [];

            req.on('data', chunk => {
                bodyChunks.push(chunk);
            });

            req.on('end', () => {
                let body = Buffer.concat(bodyChunks).toString();

                let bodyObject = new URLSearchParams(body);
                bodyObject.set('redirect_uri', "oauth-redir-uri");
                let newBody = bodyObject.toString();
                newBody = newBody.replace("oauth-redir-uri", encodeURIComponent(process.env.REDIRECT_URI));//"narwhal%3A//oauth");

                req.body = newBody;
                req.headers['content-length'] = Buffer.byteLength(newBody);

                let proxyOptions = {
                    method: req.method,
                    headers: req.headers,
                    hostname: req.headers.host,
                    path: reqUrl.pathname,
                };

                console.log(proxyOptions);

                let proxyReq = https.request(proxyOptions, function(proxyRes) {
                    let responseChunks = [];
                    
                    let stream = proxyRes;
                    const contentEncoding = proxyRes.headers['content-encoding'];
                
                    if (contentEncoding === 'gzip') {
                        stream = proxyRes.pipe(zlib.createGunzip());
                    }
                
                    stream.on('data', chunk => {
                        responseChunks.push(chunk);
                    });
                
                    stream.on('end', () => {
                        let responseBody = Buffer.concat(responseChunks).toString();
                
                        zlib.gzip(responseBody, (err, buffer) => {
                            if (err) {
                                console.error('Failed to gzip response:', err);
                                res.writeHead(500, { 'Content-Type': 'text/plain' });
                                res.end('Failed to gzip response');
                                return;
                            }
                    
                            let headers = {
                                ...proxyRes.headers,
                                'content-length': buffer.length
                            };
                    
                            res.writeHead(proxyRes.statusCode, headers);
                            res.write(buffer);
                            res.end();
                        });
                    });
                });
                
                proxyReq.setHeader('User-Agent', process.env.CLIENT_ID);
                
                proxyReq.setHeader('authorization', 'Basic ' + Buffer.from(process.env.CLIENT_ID + ':').toString('base64'));
                
                proxyReq.write(newBody);
                proxyReq.end();
                
            });
        } else {
            proxy.web(req, res, { target: `https://${req.headers.host}` });
        }
    });

    httpsServer.listen(port);
    console.log(new Date(), "Started proxy service on port " + port);
}

module.exports = startProxyServer;
