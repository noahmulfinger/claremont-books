<?php
/*
 * Claremont Books: Modify books
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
$bookid = $_GET['bookid'];

$api->grabCurrentBook($bookid, $title, $author, $isbn, $edition, $binding);

?>

<h3> Modifying Book Data </h3>
<form action=<?php echo $_SERVER['PHP_SELF']; ?> method="post">
	Title: <input type="text" name="bookTitle" value="<?php echo $title; ?>" /><br />
	Author: <input type="text" name="bookAuthor" value="<?php echo $author; ?>" /><br />
	ISBN: <input type="text" name="bookISBN" value="<?php echo $isbn; ?>" /><br />
	Edition: <input type="text" name="bookEdition" value="<?php echo $edition; ?>" /><br />
	Binding: <input type="text" name="bookBinding" value="<?php echo $binding; ?>" /><br />
	<br />

	<input type="hidden" name="bookid" value="<?php echo $bookid; ?>" />
	<input type="submit" name="submit" value="Modify!" />
</form>

<?php
	if(isset($_POST['submit'])) {
		$api->modifyBook($_POST[bookid], $_POST[bookTitle], $_POST[bookAuthor], $_POST[bookISBN], $_POST[bookEdition], $_POST[bookBinding]);
		echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
		exit;
	}

?>