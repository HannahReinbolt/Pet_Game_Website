// Run node app.js alongside apache server (don't use ports 80 or 8080, those are used by apache) 
// Http stuff
var express = require('express')();
// Server
var app = require('http').Server(express);
// Websockets
var io = require('socket.io').listen(app);
// Mysql module
var db = require('mysql').createConnection({host:'localhost', user:'root', password:'', database:'petDB'});

db.connect();

// HTTP request handling
// HTML file requests
// Home page
express.get('/*',
	function(req, res)
	{
	  res.sendFile(__dirname + "\\Website\\"+req.url);
	});

// CSS file request
express.get('/styles.css',
	    function(req, res)
	    {
              res.sendFile(__dirname + "\\styles.css");
	    });

// Socket callbacks
io.on("connection",
      function(socket)
      {
	    console.log("Socket connection!");
		// When socket disconnects, give 5 minutes to reconnect
		socket.on("disconnect",
				  function()
			      {
		            console.log("Goodbye!");
			      });
		socket.on('chatin',function(msg)
							{
								io.emit('chat',msg);
							});
		socket.on('query', function(q)
							{
								console.log("Querying db!");
								console.log(q);
								db.query(q, function(error, results, fields)
											{
												if(error)
												{
													console.log("Query fail!");
													console.log(error);
													socket.emit('qFail', error);
												}
												else
												{
													console.log("Query sucess!");
													// Send back results
													console.log(results);
													console.log(results[0].Lname);
													socket.emit('qSuccess', results);
												}
											});
							});
		
	  });

// Port and IP address
var server_port =  8081;
var server_ip_address = 'localhost';

// Begin listening for requests
app.listen(server_port, server_ip_address,
	      function()
	      {
	        console.log("Listening on " + server_ip_address + ":" + server_port);
	      });
		  
process.on('exit', function()
					{
						db.end();
						console.log("Goodbye");
					});
process.on('SIGINT', function()
					{
						//db.end();
						//console.log("Goodbye");
						process.exit()
					});