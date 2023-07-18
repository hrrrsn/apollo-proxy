const http = require('http');
const express = require('express');

function startWebServer(port, directory) {
    let app = express();

    app.use(function(req, res, next) {
      console.log(new Date(), "web", req.method, req.url);
      next();
    });
    
    app.get('/authority.crt', function(req, res) {
      res.sendFile(__dirname + '/certificates/rootCA.crt');  
    });




    // app.get('/redirect', function(req, res) {
    //   const query = new URLSearchParams(req.query);
    //   const redirectUrl = `apollo://reddit-oauth?${query.toString()}`;
    //   res.redirect(302, redirectUrl);
    // });
    
    app.use(express.static(directory));
    let httpServer = http.createServer(app);
    httpServer.listen(port);

    console.log(new Date(), "Started web server on port " + port);
}

module.exports = startWebServer;
