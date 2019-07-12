var express = require('express');
var app = express();
var httpProxy = require('http-proxy');
var apiProxy = httpProxy.createProxyServer();
//fixme
var serverOne = 'http://10.127.148.92:1550';
var log = require('intel');
//fixme
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
        log.info(req.originalUrl);
        // log.info(req.headers);

    });
 

    apiProxy.web(req, res, { target: serverOne });

});

//fixme
app.listen(3000);