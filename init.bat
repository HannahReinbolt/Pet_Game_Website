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
C:\xampp\apache_start.bat
C:\xampp\mysql_start.bat

echo Building database
cd Database
buildDb.bat build petDB
cd ..

echo Invoking local server
npm install package.json
start "Local Server" node app.js

echo Launching default browser
explorer localhost:8081