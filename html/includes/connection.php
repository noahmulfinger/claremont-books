<?php
/*
 * Claremont Books: External Connection file
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
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