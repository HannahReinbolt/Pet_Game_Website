Installation
	- Open command prompt as administrator
	- Navigate to this directory
	- Run "init.bat"

If init.bat fails, here are the manual steps it performs:

1) Make sure XAMPP and NodeJS are installed on your machine

2) Run the apache and mysql services through XAMPP

3) Prepare the database (make sure mysql and apache are running)
	- Open a command prompt
	- cd into the directory where this is downloaded
	- Run "Database\buildDb.bat build petDB"
	- Alternatively, to just create the database without preload values, run "Database\buildDb.bat create petDB"

4) Invoke the local server
	- Use the same command prompt as for step 3 (should still be in the Pet_Game_Website directory)
	- Run "npm install" (this will donwload a couple modules that we require)
	- Run "node app.js" (this will invoke the server)
	- Do not close the command prompt until finished - this will shutdown the server

5) Open browser of choice and go to "localhost:8081"

6) Enjoy! :)


After init.bat has finished running it will leave 4 processes up: your default browser, a call to node.js ("LocalServer"), the mysql service ("mysql"), and the apache service ("apache").
Just terminate those with the red X button whe you're finished.