var express = require('express');
var app = express();
var httpProxy = require('http-proxy');
var apiProxy = httpProxy.createProxyServer();
var serverOne = 'http://192.168.1.52:1560';
var log = require('intel');
log.addHandler(new log.handlers.File('./log/project.log'));
log.addFilter(new log.Filter(/^.*d2p1:measure.*$/g));
var parseString = require('xml2js').parseString;


app.all("/*", function (req, res) {

    var jsonStringreq = '';
    req.on('data', function (data) {
        jsonStringreq += data;
    });

    req.on('end', function () {

        parseString(jsonStringreq, {trim: true, explicitArray:false}, function(err, result){
            log.info(JSON.stringify(result));
        });
      
        // log.info(jsonStringreq);

    });
 

    apiProxy.web(req, res, { target: serverOne });

});


app.listen(3000);