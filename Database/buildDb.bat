echo off
set mode=%1

if %mode%==help (
	echo syntax: buildDb.at command dbName
	echo Commands:
	echo 	create 	 :  creates database dbName and builds it from dbSchema.sql
	echo 	load 	 :  loads dbPreload.sql into existing database dbName
	echo 	build 	 :  same as create + load - loads both dbSchema.sql and dbPreload.sql
	echo		destroy  :  drop existing database dbName
	echo 	help 	 :  display this help section
	echo Make sure to launch apache and mysql in XAMPP before using this tool! :P
	exit /B)
	
set dbname=%2
set mysql="C:\xampp\mysql\bin\mysql.exe"

if %mode%==destroy (%mysql% -u root  -e "drop database %dbname%")
if %mode%==create (
	%mysql% -u root -e "create database %dbname%"
	%mysql% -u root %dbname% < dbSchema.sql)
if %mode%==load (%mysql% -u root %dbname% < dbPreload.sql)
if %mode%==build (
	%mysql% -u root -e "create database %dbname%"
	%mysql% -u root %dbname% < Database\dbSchema.sql
	%mysql% -u root %dbname% < Database\dbPreload.sql)