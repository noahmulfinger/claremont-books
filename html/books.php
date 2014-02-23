<?php 
/*
 * Claremont Books: List all books currently in database
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 */

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
	echo '<table style="width:600px">
		<tr>
		  <th>Book ID</th>
		  <th>Title</th> 
		  <th>Author</th>
		  <th>ISBN</th>
		  <th>Edition</th>
		  <th>Binding</th>
		  <th>Modify</th>
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
		echo "<td>" . "<a href=\"modify.php?bookid=" . $currentBooks['bookid'] . "\"> Edit</a>" . "&nbsp" . "<a href=\"delete.php?bookid=" . $currentBooks['bookid'] . "\"> Delete</a>" . "</td>";
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
<!--
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
-->
</body>
</html>