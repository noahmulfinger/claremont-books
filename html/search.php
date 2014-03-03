<?php
/*
 * Claremont Books: Search Books (place for users to search for book attributes)
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


// TODO: implement for grabbing browser information
	// Grab whatever values that are currently available to us (use isset)
	// $title = $_GET['bookTitle'];
	// $author = $_GET['bookAuthor'];
	// $isbn = $_GET['bookISBN'];
	// $edition = $_GET['bookEdition'];
	// $binding = $_GET['bookBinding'];
	// $password = $_GET['password'];

?>
<html>
<head><title> Search current book database</title>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48321922-1', 'claremontbooks.com');
  ga('send', 'pageview');

</script>
<link rel="stylesheet" type="text/css" media="all" href="style.css" />
</head>

<body>
<h3> Search for an existing book in the database, enter any of all of the fields below: </h3>
<form action=<?php echo $_SERVER['PHP_SELF']; ?> method="post">
<?php /*
	Title: <input type="text" name="bookTitle" value="<?php echo $book['title']; ?>" /><br />
	Author: <input type="text" name="bookAuthor" value="<?php echo $book['author']; ?>" /><br />
	ISBN: <input type="text" name="bookISBN" value="<?php echo $book['isbn']; ?>" /><br />
	Edition: <input type="text" name="bookEdition" value="<?php echo $book['edition']; ?>" /><br />
	Binding: <input type="text" name="bookBinding" value="<?php echo $book['binding']; ?>" /><br />

	<input type="hidden" name="bookid" value="<?php echo $_GET['bookid']; ?>" />
	*/ ?>
	<?php /* Original
	Title: <input type="text" name="bookTitle" value="" /><br />
	Author: <input type="text" name="bookAuthor" value="" /><br />
	ISBN: <input type="text" name="bookISBN" value="" /><br />
	Edition: <input type="text" name="bookEdition" value="" /><br />
	Binding: <input type="text" name="bookBinding" value="" /><br />
	*/ ?>
	Omni Search: <input type="text" name="omniSearch" value="" /><br />
	<br />

	
	<input type="submit" name="submit" value="Search!" />
</form>

<?php
	if(isset($_POST['submit'])) {
			// for testing
			//$query = "SELECT * FROM Book WHERE `title` LIKE '%logic%'";
			//echo "The thing you entered was: " . mysql_real_escape_string($_POST['omniSearch']);
		$query = "SELECT * FROM `Book` WHERE (`bookid` LIKE '%".mysql_real_escape_string($_POST['omniSearch'])."%' OR `title` LIKE '%".mysql_real_escape_string($_POST['omniSearch'])."%' OR `author` LIKE '%".mysql_real_escape_string($_POST['omniSearch'])."%' OR `isbn` LIKE '%".mysql_real_escape_string($_POST['omniSearch'])."%' OR `edition` LIKE '%".mysql_real_escape_string($_POST['omniSearch'])."%' OR `binding` LIKE '%".mysql_real_escape_string($_POST['omniSearch'])."%')";
		$result = mysql_query($query) or die (mysql_error());

		//echo "Successful modification!";
		//can't redirect using headers if output already started
		//header("Location: http://www.claremontbooks.com/books.php");
?>
<h3> Current search result of books in database </h3>
<?php
	
		// Output Listings to table format
		echo '<table style="width:600px">
			<tr>
			  <th>Book ID</th>
			  <th>Title</th> 
			  <th>Author</th>
			  <th>ISBN</th>
			  <th>Edition</th>
			  <th>Binding</th>
			</tr>';
		// table row data below
		while ($currentBooks = mysql_fetch_array($result))
		{
			echo "<tr>";
			echo "<td>" . $currentBooks['bookid'] . "</td>";
			echo "<td>" . $currentBooks['title'] . "</td>";
			echo "<td>" . $currentBooks['author'] . "</td>";
			echo "<td>" . $currentBooks['isbn'] . "</td>";
			echo "<td>" . $currentBooks['edition'] . "</td>";
			echo "<td>" . $currentBooks['binding'] . "</td>";
			echo "</tr>";
		}
		echo '</table>';
	}
	// echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';
	// exit;
?>
</body>
</html>