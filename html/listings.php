<?php
/*
 * Claremont Books: List all current listings
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 */
?>

<html>
<head><title> Current Listings </title>

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
<h3> Current Listings </h3>

<?php 
	include 'includes/connection.php';

	$query = "SELECT L.listid, B.title, B.author, B.edition, L.price FROM Listings L, Book B WHERE L.bookid = B.bookid";

	$result = mysql_query($query);
	
	// Output Listings to table format
	echo '<table style="width:500px">
		<tr>
		  <th>List ID</th>
		  <th>Title</th> 
		  <th>Author</th>
		  <th>Edition</th>
		  <th>Price</th>
		</tr>';
	// table row data below
	while ($currentListings = mysql_fetch_array($result))
	{
		echo "<tr>";
		echo "<td>" . $currentListings['listid'] . "</td>";
		echo "<td>" . $currentListings['title'] . "</td>";
		echo "<td>" . $currentListings['author'] . "</td>";
		echo "<td>" . $currentListings['edition'] . "</td>";
		echo "<td>" . $currentListings['price'] . "</td>";
		echo "</tr>";
	}
	echo '</table>';
?>

</body>
</html>