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
include 'includes/functions.php';

// This is the first thing that gets called when this page is loaded
// Creates a new instance of the Books class
$api = new Books;

// Grab bookid variable from URL
$bookid = $_POST['bookid'];

// ensure that people got to this form from the correct place
if (!$_POST['submit']) {
	// Immediatebly takes user back to listing of books
	//echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
	//echo "Where did you come from?";
	header("Location: books.php");
	exit;
} else {
	// Inserts the book with variables passed in
	$api->deleteBook($bookid);
	echo "Book has been deleted!";
	echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
	exit;
}
?>