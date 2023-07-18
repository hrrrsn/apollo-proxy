const fs = require('fs');
const forge = require('node-forge');
const os = require('os');

function generateCertificates() {
    // Certificate Authority
    if (!fs.existsSync('certificates/rootCA.crt')) {
        // Generate root CA
        console.log(new Date(), "Generating a new certificate authority");

        const rootKeys = forge.pki.rsa.generateKeyPair(4096);
        const rootCert = forge.pki.createCertificate();
        rootCert.publicKey = rootKeys.publicKey;
        rootCert.serialNumber = '01';
        rootCert.validity.notBefore = new Date();
        rootCert.validity.notAfter = new Date();
        rootCert.validity.notAfter.setFullYear(rootCert.validity.notBefore.getFullYear() + 10);

        const rootAttrs = [{
            name: 'commonName',
            value: `apollo-proxy (${new Date().toISOString().slice(0, 10)}, ${os.hostname()})`
        }];

        rootCert.setSubject(rootAttrs);
        rootCert.setIssuer(rootAttrs);
        rootCert.setExtensions([{
            name: 'basicConstraints',
            cA: true
        }]);

        const md = forge.md.sha256.create();
        rootCert.sign(rootKeys.privateKey, md);
    
        fs.writeFileSync('certificates/rootCA.key', forge.pki.privateKeyToPem(rootKeys.privateKey));
        fs.writeFileSync('certificates/rootCA.crt', forge.pki.certificateToPem(rootCert));
    }
  
    const rootPrivateKeyPem = fs.readFileSync('certificates/rootCA.key');
    const rootCertPem = fs.readFileSync('certificates/rootCA.crt');
    const rootPrivateKey = forge.pki.privateKeyFromPem(rootPrivateKeyPem);
    const rootCert = forge.pki.certificateFromPem(rootCertPem);

    // SSL certificate
    if (!fs.existsSync('certificates/reddit.key') || !fs.existsSync('certificates/reddit.crt')) {
        // Generate a new certificate for "*.reddit.com"

        console.log(new Date(), "Generating a new certificate for *.reddit.com and apollogur.download");

        const keys = forge.pki.rsa.generateKeyPair(2048);
        const cert = forge.pki.createCertificate();
        cert.publicKey = keys.publicKey;
        cert.serialNumber = '02';
        cert.validity.notBefore = new Date();
        cert.validity.notAfter = new Date();
        cert.validity.notAfter.setFullYear(cert.validity.notBefore.getFullYear() + 1);
        const attrs = [
            { name: 'commonName', value: '*.reddit.com' },
            { name: 'organizationName', value: 'apollo-proxy' }
        ];
        cert.setSubject(attrs);
        cert.setIssuer(rootCert.subject.attributes);
        cert.setExtensions([{
            name: 'basicConstraints',
            cA: false
        }, {
            name: 'keyUsage',
            digitalSignature: true,
            keyEncipherment: true,
        }, {
            name: 'extKeyUsage',
            serverAuth: true
        }, {
            name: 'subjectAltName',
            altNames: [
                { type: 2, value: '*.reddit.com' },
                { type: 2, value: 'apollogur.download' }
            ]
        }]);

        const md = forge.md.sha256.create();
        cert.sign(rootPrivateKey, md);
  
        fs.writeFileSync('certificates/reddit.key', forge.pki.privateKeyToPem(keys.privateKey));
        fs.writeFileSync('certificates/reddit.crt', forge.pki.certificateToPem(cert));
  
        const fullChain = forge.pki.certificateToPem(cert) + '\n' + rootCertPem;
        fs.writeFileSync('certificates/fullchain.crt', fullChain);
    }
}

module.exports = generateCertificates;