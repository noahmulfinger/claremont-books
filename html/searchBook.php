<?php 
	include 'includes/connection.php';

	$query = "SELECT * FROM Book";

	$result = mysql_query($query);
?>
<html>
<head><title> Current Books </title>

<style>
body {
	font: 10pt/1.4em Arial, Helvetica, sans-serif;
	color: #444444;
}
table, th, td {
	border: 1px solid #cccccc;
	border-collapse: collapse;
}
</style>

</head>

<body>

<h3> Books in Database that match the search result </h3>
<?php
	
	// Output Listings to table format
	echo '<table style="width:500px">
		<tr>
		  <th>Book ID</th>
		  <th>Title</th> 
		  <th>Author</th>
		  <th>ISBN</th>
		  <th>Edition</th>
		  <th>Binding</th>
		</tr>';
	// table row data below
	while ($currentListings = mysql_fetch_array($result))
	{
		echo "<tr>";
		echo "<td>" . $currentListings['bookid'] . "</td>";
		echo "<td>" . $currentListings['title'] . "</td>";
		echo "<td>" . $currentListings['author'] . "</td>";
		echo "<td>" . $currentListings['isbn'] . "</td>";
		echo "<td>" . $currentListings['edition'] . "</td>";
		echo "<td>" . $currentListings['binding'] . "</td>";
		echo "</tr>";
	}
	echo '</table>';


	// local variables 
	$title = $_POST['bookTitle'];
	$author = $_POST['bookAuthor'];
	$isbn = $_POST['bookISBN'];
	$edition = $_POST['bookEdition'];
	$binding = $_POST['bookBinding'];


	// ensure that people got to this form from the correct place
	if (!$_POST['submit']) {
		//echo "Please fill out the form!";
		header("Location: http://www.claremontbooks.com/books.php");
		exit;
	} else {
		$query = "INSERT INTO Book (`title`, `author`, `edition`, `binding`, `isbn`) VALUES ('$title','$author','$edition','$binding','$isbn')";

		mysql_query($query) or die (mysql_error());
		//echo "Book has been added!";
		header("Location: http://www.claremontbooks.com/books.php");
		exit;
	}
?>

<h3> Search for an existing book in the database, enter any of all of the fields below:</h3>
<form action="searchBook.php" method="post">
	Title: <input type="text" name="bookTitle" value="" /><br />
	Author: <input type="text" name="bookAuthor" value="" /><br />
	ISBN: <input type="text" name="bookISBN" value="" /><br />
	Edition: <input type="text" name="bookEdition" value="" /><br />
	Binding: <input type="text" name="bookBinding" value="" /><br />
	<br />

	<input type="submit" name="submit" />
</form>

</body>
</html>

SELECT * FROM Customers
WHERE City LIKE 's%' OR ContactName LIKE 'f%';

