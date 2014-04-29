<?php
/*
 * Claremont Books: Add a new book via mobile phone, has a basic password protection
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 * Usage: On the phone's interface books, use this link: http://www.claremontbooks.com/insertBookMobile.php?bookTitle=title&bookAuthor=bywho&bookEdition=1&bookBinding=soft&bookISBN=123456&password=secret
 */

include 'includes/functions.php';

session_start();

$api = new Listings;

if($_POST) {
	if(isset($_POST['bookid']) && isset($_POST['price']) && isset($_POST['userid'])) {
		
		$bookid = $_POST['bookid'];
		$price = $_POST['price'];
		$userid = $_POST['userid'];

		$api->addListing($bookid, $price, $userid);

		echo '{"success":1}';

	} else {
		echo '{"success":0,"error_message":"One or more entries was not set correctly."}';
	}
} else {
	echo '{"success":0,"error_message":"This page was not accessed via posting."}';
}

// This is the first thing that gets called when this page is loaded
// Creates a new instance of the Books class


// local variables 
// $title = $_GET['bookTitle'];
// $author = $_GET['bookAuthor'];
// $isbn = $_GET['bookISBN'];
// $edition = $_GET['bookEdition'];
// $binding = $_GET['bookBinding'];
// $password = $_GET['password'];

// $secret = 'secret';


// ensure that people got to this form from the correct place (i.e. using a password)
// if ($_GET['password'] == $secret) {
// 	// Inserts the book with variables passed in
// 	$api->insertBooksWeb($title, $author, $isbn, $edition, $binding);
// 	//echo "Success!";

// 	exit;
// } else {
// 	echo "Invalid Password!";
// 	//echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';

// 	//echo "Book has been added!";
// 	// echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
// 	exit;
// }
?>