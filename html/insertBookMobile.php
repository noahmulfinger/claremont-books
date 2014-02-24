<?php
/*
 * Claremont Books: Add a new book via mobile phone, has a basic password protection
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 * Usage: On the phone's interface books, use this link: http://www.claremontbooks.com/insertBookMobile.php?bookTitle=title&bookAuthor=bywho&bookEdition=1&bookBinding=soft&bookISBN=123456
 */

	include 'includes/connection.php';

	// local variables 
	$title = $_GET['bookTitle'];
	$author = $_GET['bookAuthor'];
	$isbn = $_GET['bookISBN'];
	$edition = $_GET['bookEdition'];
	$binding = $_GET['bookBinding'];
	$password = $_GET['password'];

	$password = 'secret';


	// ensure that people got to this form from the correct place (i.e. using a password)
	if ($_GET['password'] == $password) {

		$query = "INSERT INTO Book (`title`, `author`, `edition`, `binding`, `isbn`) VALUES ('$title','$author','$edition','$binding','$isbn')";

		mysql_query($query) or die (mysql_error());
		exit;
	} else {
		echo "Invalid Password!";
		//echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';

		//echo "Book has been added!";
		// echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
		exit;
	}
?>