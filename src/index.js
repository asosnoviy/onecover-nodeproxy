var express = require('express');
var app = express();
var httpProxy = require('http-proxy');
var apiProxy = httpProxy.createProxyServer();
var serverOne = 'http://localhost:1550';
var log = require('intel');
log.addHandler(new log.handlers.File('./project.log'));
log.addFilter(new log.Filter(/^.*lineNo.*$/g));



app.all("/*", function (req, res) {

    var jsonStringreq = '';
    req.on('data', function (data) {
        jsonStringreq += data;
    });

    req.on('end', function () {

        log.info(jsonStringreq);

    });

    apiProxy.web(req, res, { target: serverOne });

});


app.listen(3000);