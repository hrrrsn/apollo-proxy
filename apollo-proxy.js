require('dotenv').config();
const generateCertificates = require('./certificates');
const startWebServer = require('./webServer');
const startProxyServer = require('./proxyServer');

const webServerPort = process.env.WEB_SERVER_PORT || 80;
const proxyPort = process.env.PROXY_PORT || 443;

// Generate certificates
generateCertificates();

startWebServer(webServerPort, 'public');
startProxyServer(proxyPort);