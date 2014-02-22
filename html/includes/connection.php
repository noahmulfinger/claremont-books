<?php
/*
 * CS 121: MySQL External Database connection file
 * 
 * Author: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 * Project: Claremont-Books App
 *
*/

	$dbhost = 'mysql.claremontbooks.com';
	$dbuser = 'cbooks';
	$dbpass = 'Claremontbooks2014$';
	$dbname = 'cbooksdb';

	// Initiate connection to server
	$conn = mysql_connect($dbhost, $dbuser, $dbpass);

	// Select the database to operate on
	mysql_select_db($dbname);
?>