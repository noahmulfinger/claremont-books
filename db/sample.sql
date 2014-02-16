/*
 * CS 121: Sample book database
 * 
 * Author: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 * Project: Claremont-Books App
 *
*/



/* Database setup */

# Create an empty database 
DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;

# Grant privileges to user 'bruce' with password 'yan'
GRANT ALL PRIVILEGES ON bookstore.* to bruce@localhost IDENTIFIED BY 'yan';

# Explicitly use ps1db that we just created 
USE bookstore;

/* Database table creation */
CREATE TABLE Users (
	uid INTEGER NOT NULL,
	name VARCHAR(256) NOT NULL,
	uemail VARCHAR(64) NOT NULL,
	school VARCHAR(64) NOT NULL,
	profile VARCHAR(64),
	phone VARCHAR(64),
	PRIMARY KEY (custid)
);

# Book DB needs to have books existing in it before any listings can be created
CREATE TABLE Book (
	bookid INTEGER NOT NULL,
	title VARCHAR(256) NOT NULL,
	author VARCHAR(256) NOT NULL,
	isbn VARCHAR(64) NOT NULL,
	PRIMARY KEY (bookid)
);

# Listings 
CREATE TABLE Listings (
	listid INTEGER NOT NULL, #auto increment
	bookid INTEGER NOT NULL, #matches with an existing book
	title VARCHAR(256) NOT NULL,
	quantity INTEGER NOT NULL,
	price DOUBLE NOT NULL,
	sellerid INTEGER NOT NULL, #This should be same as one of the users, allows sellers to mark items as sold, etc
	PRIMARY KEY (listid)
);

CREATE TABLE Class (
	classid VARCHAR(64) NOT NULL,
	classname VARCHAR(256) NOT NULL,
	school VARCHAR(64),
	PRIMARY KEY (classid)
);

# Create sample users
INSERT INTO Users (uid, name, uemail, school) VALUES (100001, "Bruce", "byan@hmc.edu", "HMC");
INSERT INTO Users (uid, name, uemail, school) VALUES (100001, "Bruce", "byan@hmc.edu", "HMC");


INSERT INTO Users (custid, name, phone) VALUES (0, "Jack", "70410");
INSERT INTO Users (custid, name, phone) VALUES (1, "Jill", "70411");

INSERT INTO Book (bookid, name, author, price) VALUES (0, "DBMS", "Rama", 140.97);

INSERT INTO Book (bookid, name, author, price) VALUES (1,"Open Life", "Campbell", 11.0);

INSERT INTO Book (bookid, name, author, price) VALUES (2,"What?", "Nagel", 7.95);

INSERT INTO Buy (custid, bookid, quantity) VALUES (0, 0, 3);
INSERT INTO Buy (custid, bookid, quantity) VALUES (0, 1, 5);
INSERT INTO Buy (custid, bookid, quantity) VALUES (0, 2, 7);

/*
SELECT * FROM Users, Book;

SELECT * FROM Users;
*/

-- SELECT * FROM Users, Book WHERE custid = 0 or (bookid = 2 and price > 100);

SELECT * FROM Users;

SELECT * FROM Users, Book;

SELECT * FROM Users, Book WHERE custid = 0 and bookid = 2;


