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
	
create table BAN(
	Username varchar(255) references USER.Username,
	Password varchar(255) references USER.Password,
	expiration_date date,
	primary key (Username, Password));
	
create table BAN2(
	Username varchar(255) references USER.Username,
	Password varchar(255) references USER.Password,
	reason varchar(255),
	primary key (Username, Password, reason));
	
create table BUY_PET(
	Username varchar(255) references USER.Username,
	Password varchar(255) references USER.Password,
	Pet_ID   varchar(255) references PET.ID,
	primary key (Username, Password, Pet_ID));
	
create table BUY_COS(
	Username varchar(255) references USER.Username,
	Password varchar(255) references USER.Password,
	Cos_ID   varchar(255) references COSMETIC.ID,
	primary key (Username, Password, Cos_ID));
	
create table PET(
	ID       varchar(255),
	name     varchar(255) not null default "pet_name",
	cost     int not null default 0,
	sprite   varchar(255), /* filepath to picture */
	primary key (ID));

create table COSMETIC(
	ID varchar(255),
	name varchar(255),
	cost int not null,
	sprite varchar(255),
	primary key (ID));

create table WEAR(
	Pet_ID varchar(255) references PET.ID,
	Cost_ID varchar(255) references COSMETIC.ID,
	primary key (Pet_ID, Cost_ID));

create table ACHIEVEMENT(
	Name varchar(255),
	Pet_ID varchar(255) references PET.ID,
	reward int not null,
	primary key (Name, Pet_ID));

create table AWARD(
	Name varchar(255) references ACHIEVEMENT.Name,
	Pet_ID varchar(255) references ACHIEVEMENT.Pet_ID,
	primary key (Name, Pet_ID));
