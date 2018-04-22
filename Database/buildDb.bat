echo off
set mode=%1

if %mode%==help (
	echo syntax: buildDb.at command [dbName] [sqlFile]
	echo Parameters:
	echo 		command	 :	the command to execute - listed below
	echo		dbName	 :	name of the database to execute command on - needed for everything except for the help command
	echo		sqlFile	 :	path to the sql file to load into dbName	- needed by the run command
	echo Commands:
	echo 	create 	 :  creates database dbName and builds it from dbSchema.sql
	echo 	load 	 :  loads dbPreload.sql into existing database dbName
	echo 	build 	 :  same as create + load - loads both dbSchema.sql and dbPreload.sql
	echo		destroy  :  drop existing database dbName
	echo 	help 	 :  display this help section
	echo 	run 	 :  load your own sql file
	echo Make sure to launch apache and mysql in XAMPP before using this tool! :P
	exit /B)
	
set dbname=%2
set mysql="C:\xampp\mysql\bin\mysql.exe"

if %mode%==destroy (
	%mysql% -u root -e "drop database %dbname%"
	exit /B)
if %mode%==create (
	%mysql% -u root -e "create database %dbname%"
	%mysql% -u root %dbname% < dbSchema.sql
	exit /B)
if %mode%==load (
	%mysql% -u root %dbname% < dbPreload.sql
	exit /B)
if %mode%==build (
	%mysql% -u root -e "create database %dbname%"
	%mysql% -u root %dbname% < dbSchema.sql
	%mysql% -u root %dbname% < dbPreload.sql
	exit /B)
if %mode%==run (
	%mysql% -u root %dbName% < %3
	exit /B)