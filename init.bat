echo off

echo Making sure NodeJS is installed..
node -v
if %errorlevel% NEQ 0 (
	echo Error: failed to detect NodeJS!
	pause
	exit /B)

echo Detecting C:\xampp
if not exist C:\xampp (
	echo Error: could not find XAMPP!
	pause
	exit /B)
	
echo Invoking apache and mysql services
start "apache" C:\xampp\apache_start.bat
start "mysql" C:\xampp\mysql_start.bat

timeout /t 7 /nobreak

echo Building database
cd Database
call buildDb.bat destroy petDB
call buildDb.bat build petDB
cd ..

echo Installing nodeJS modules
call npm install
echo Invoking local server
start "LocalServer" node app.js
timeout /t 3 /nobreak

echo Launching default browser
explorer http:\\localhost:8081
echo Please terminate the processes "LocalServer", "apache", and "mysql" - using the red X button will suffice