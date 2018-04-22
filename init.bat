echo off
echo Checking for NodeJS
node -v
if errorlevel(
	echo Error, NodeJS not detected! Please install NodeJS and try again!
)

echo Starting apache and mysql servers
C:\xampp\apache\bin\httpd -k start
C:\xampp\mysql\bin\mysqld -k start

echo Building database...
Database\buildDb.bat build petDb

echo Starting local server
start "Local Server" node app.js

echo Launching default browser...
explorer "localhost:8081"