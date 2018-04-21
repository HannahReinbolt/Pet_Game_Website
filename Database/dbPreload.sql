/* This sql file loads in some default values into our database. Add yourself as admin */

insert into USER values ('frodoHackins', 'toor', 'Frodo', null, 'Hackins', '1998-02-26', 999, null);
insert into USER2 values ('frodoHackins', 'toor', '5736664200', 'svgntc@mst.edu');
insert into ADMIN values ('frodoHackins', 'toor');
insert into CUSTOMER values ('frodoHackins', 'toor', 3);
insert into BAN values ('frodoHackins', 'toor', '01-01-9999');
insert into BAN2 values ('frodoHackins', 'toor', 'everything o_O');

insert into USER values ('SirDalyn', 'StrongPassword', 'Sir', 'Gwen', 'Dalyn', '1996-07-28', 420, null);
insert into USER2 values ('SirDalyn', 'StrongPassword', '3141592653', 'gmw7x9@mst.edu');
insert into ADMIN values ('SirDalyn', 'StrongPassword');
insert into CUSTOMER values ('SirDalyn', 'StrongPassword', 0); 