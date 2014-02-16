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
	PRIMARY KEY (uid)
);

# Book DB needs to have books existing in it before any listings can be created
CREATE TABLE Book (
	bookid INTEGER NOT NULL,
	title VARCHAR(256) NOT NULL,
	author VARCHAR(256) NOT NULL,
	isbn INTEGER NOT NULL,
	edition INTEGER,
	binding VARCHAR(64),
	PRIMARY KEY (bookid)
);

# Listings 
CREATE TABLE Listings (
	listid INTEGER NOT NULL, #auto increment
	bookid INTEGER NOT NULL, #matches with an existing book
	#title VARCHAR(256) NOT NULL,
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
INSERT INTO Users (uid, name, uemail, school) VALUES (100002, "Chris", "ceriksen@hmc.edu", "HMC");
INSERT INTO Users (uid, name, uemail, school) VALUES (100003, "Noah", "noah.mulfinger@gmail.com", "POM");

# Create sample books
INSERT INTO Book (bookid, title, author, edition, binding, isbn) VALUES (0, "Design Patterns", "Erich Gamma", 5, "Hard Cover", 0201633612);
INSERT INTO Book (bookid, title, author, edition, binding, isbn) VALUES (1, "Proof and Disproof in Formal Logic: An Introduction for Programmers", "Richard Bornat", 2, "Soft Cover", 0198530277);
INSERT INTO Book (bookid, title, author, edition, binding, isbn) VALUES (2, "Introduction to the Theory of Computation", "Michael Sipser", 3, "Hard Cover", 0534950973);

# Create sample listings
INSERT INTO Listings (listid, bookid, quantity, price, sellerid) VALUES (0, 1, 1, 35.50, 100002);
INSERT INTO Listings (listid, bookid, quantity, price, sellerid) VALUES (1, 2, 1, 50, 100002);
INSERT INTO Listings (listid, bookid, quantity, price, sellerid) VALUES (2, 0, 1, 15, 100001);

