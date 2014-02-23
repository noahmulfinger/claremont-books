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

	include 'includes/connection.php';
	// If info has not been posted, then we grab some data from the DB
	if(!isset($_POST['submit'])) {
		$query = "SELECT * FROM Book WHERE bookid = $_GET[bookid]";
		$result = mysql_query($query) or die ($query."<br/><br/>".mysql_error());
		//store result array into a variable
		$book = mysql_fetch_array($result);
	}
?>

<h3> Modifying Book Data </h3>
<form action=<?php echo $_SERVER['PHP_SELF']; ?> method="post">
	Title: <input type="text" name="bookTitle" value="<?php echo $book['title']; ?>" /><br />
	Author: <input type="text" name="bookAuthor" value="<?php echo $book['author']; ?>" /><br />
	ISBN: <input type="text" name="bookISBN" value="<?php echo $book['isbn']; ?>" /><br />
	Edition: <input type="text" name="bookEdition" value="<?php echo $book['edition']; ?>" /><br />
	Binding: <input type="text" name="bookBinding" value="<?php echo $book['binding']; ?>" /><br />
	<br />

	<input type="hidden" name="bookid" value="<?php echo $_GET['bookid']; ?>" />
	<input type="submit" name="submit" value="Modify!" />
</form>

<?php
	if(isset($_POST['submit'])) {
		// actually perform the update with modified values
		$update = "UPDATE Book SET `title`='$_POST[bookTitle]', `author`='$_POST[bookAuthor]', `isbn`='$_POST[bookISBN]', `edition`='$_POST[bookEdition]', `binding`='$_POST[bookBinding]' WHERE bookid = $_POST[bookid]";
		mysql_query($update) or die (mysql_error());

		//echo "Successful modification!";
		//can't redirect using headers if output already started
		//header("Location: http://www.claremontbooks.com/books.php");
		
		echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
		exit;
	}

?>