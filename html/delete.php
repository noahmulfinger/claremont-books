<?php
/*
 * Claremont Books: Delete books
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 */
	include 'includes/connection.php';

	//Grab the book ID from the URL passed in
	$query = "DELETE FROM Book WHERE bookid = $_GET[bookid]";

	mysql_query($query) or die (mysql_error());
	//echo "Book has been added!";
	echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
	exit;
?>