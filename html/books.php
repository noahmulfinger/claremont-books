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

<h3> Current books in database </h3>
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
?>

<h3> Insert a new Book into the Database </h3>
<form action="insertBook.php" method="post">
	Title: <input type="text" name="bookTitle" value="" /><br />
	Author: <input type="text" name="bookAuthor" value="" /><br />
	ISBN: <input type="text" name="bookISBN" value="" /><br />
	Edition: <input type="text" name="bookEdition" value="" /><br />
	Binding: <input type="text" name="bookBinding" value="" /><br />
	<br />

	<input type="submit" name="submit" />
</form>

<h3> Search for an existing book in the database </h3>
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