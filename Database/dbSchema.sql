/*
This file contains all the schemas for the relations in our database. Used to build the database as needed.
*/

create table USER(
	Username varchar(255) unique,
	Password varchar(255),
	Fname varchar(255),
	Mname varchar(255),
	Lname varchar(255),
	Dob date,
	Money int not null default 0,
	Picture varchar(255) not null default 'Sprites/potato.png',
	primary key (Username,Password));
	
create table USER2(
	Username varchar(255),
	Phone char(10),
	Email varchar(255),
	primary key (Username,Phone,Email),
	foreign key (Username) references USER (Username) on delete cascade);

create table CUSTOMER(
	Username varchar(255),
	Numstrikes int(3),
	primary key (Username),
	foreign key (Username) references USER (Username) on delete cascade);
	
create table ADMIN(
	Username varchar(255),
	primary key (Username),
	foreign key (Username) references USER (Username) on delete cascade);
	
create table BAN(
	Username varchar(255),
	expiration_date date,
	primary key (Username),
	foreign key (Username) references USER (Username) on delete cascade);
	
create table BAN2(
	Username varchar(255),
	reason varchar(255),
	primary key (Username, reason),
	foreign key (Username) references USER (Username) on delete cascade);
	
create table BUY_PET(
	Username varchar(255),
	Pet_ID   varchar(255) references PET.ID,
	primary key (Username, Pet_ID),
	foreign key (Username) references USER (Username) on delete cascade);
	
create table BUY_COS(
	Username varchar(255),
	Cos_ID   varchar(255) references COSMETIC.ID,
	primary key (Username, Cos_ID),
	foreign key (Username) references USER (Username) on delete cascade);
	
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
	Username varchar(255),
	Cos_ID varchar(255) references COSMETIC.ID,
	primary key (Username, Cos_ID),
	foreign key (Username) references USER (Username) on delete cascade);

create table ACHIEVEMENT(
	Name varchar(255),
	Pet_ID varchar(255) references PET.ID,
	reward int not null,
	primary key (Name, Pet_ID));

create table AWARD(
	Name varchar(255) references ACHIEVEMENT.Name,
	Pet_ID varchar(255) references ACHIEVEMENT.Pet_ID,
	primary key (Name, Pet_ID));
