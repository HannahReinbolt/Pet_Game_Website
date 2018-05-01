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

// Schedule deletion of expired bans
setInterval(function()
{
	var todayDate = new Date(Date.now());
	var today = ""+todayDate.getFullYear()+"-"+("0"+(todayDate.getMonth()+1)).slice(-2)+"-"+("0"+todayDate.getDate()).slice(-2);
	console.log(today);
	var qry = "delete from BAN where expiration_date < '"+today+"'";
	console.log(qry);
	db.query(qry, function(error, results, fields)
	{
		console.log(results);
		console.log(error);
	});
}, 60000/*3600000*/);

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
								query = JSON.parse(q);
								db.query(query.query, function(error, results, fields)
											{
												if(error)
												{
													console.log("Query fail!");
													console.log(error);
													socket.emit("fail"+query.id, error);
												}
												else
												{
													console.log("Query sucess!");
													// Send back results
													if(results.length < 1)
													{
														console.log("No results");
														socket.emit("fail"+query.id, "No match");
													}
													else
													{
														console.log(results);
														socket.emit("success"+query.id, results);
													}
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