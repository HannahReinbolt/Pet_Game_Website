// Run node app.js alongside apache server (don't use ports 80 or 8080, those are used by apache) 
// Http stuff
var express = require('express')();
// Server
var app = require('http').Server(express);
// Websockets
var io = require('socket.io').listen(app);

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
								console.log(msg);
								io.emit('chat',msg);
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