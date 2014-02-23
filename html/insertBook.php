<?php
/*
 * Claremont Books: Add a new book
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 */

	include 'includes/connection.php';

	// local variables 
	$title = $_POST['bookTitle'];
	$author = $_POST['bookAuthor'];
	$isbn = $_POST['bookISBN'];
	$edition = $_POST['bookEdition'];
	$binding = $_POST['bookBinding'];


	// ensure that people got to this form from the correct place
	if (!$_POST['submit']) {
		//echo "Please fill out the form!";
		echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
		exit;
	} else {
		$query = "INSERT INTO Book (`title`, `author`, `edition`, `binding`, `isbn`) VALUES ('$title','$author','$edition','$binding','$isbn')";

		mysql_query($query) or die (mysql_error());
		//echo "Book has been added!";
		echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
		exit;
	}
?>