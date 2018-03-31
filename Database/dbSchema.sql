/*
This file contains all the schemas for the relations in our database. Used to build the database as needed.
*/

create table USER(
	Username varchar(255),
	Password varchar(255),
	Fname varchar(255),
	Mname varchar(255),
	Lname varchar(255),
	Dob date,
	Money int not null default 0,
	Picture varchar(255), /* filepath to picture */
	primary key (Username,Password));
	
create table USER2(
	Username varchar(255) references USER.Username,
	Password varchar(255) references USER.Password,
	Phone char(10),
	Email varchar(255),
	primary key (Username,Password,Phone,Email));

create table CUSTOMER(
	Username varchar(255) references USER.Username,
	Password varchar(255) references USER.Password,
	Numstrikes int(3),
	primary key (Username, Password));
	
create table ADMIN(
	Username varchar(255) references USER.Username,
	Password varchar(255) references USER.Password,
	primary key (Username, Password));