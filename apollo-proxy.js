require('dotenv').config();
const generateCertificates = require('./certificates');
const startWebServer = require('./webServer');
const startProxyServer = require('./proxyServer');

// Generate certificates
generateCertificates();
startWebServer(process.env.WEB_SERVER_PORT, 'public');
startProxyServer(process.env.PROXY_PORT);
