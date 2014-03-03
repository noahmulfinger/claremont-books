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
include 'includes/functions.php';

// This is the first thing that gets called when this page is loaded
// Creates a new instance of the Books class
$api = new Listings;

?>

<html>
<head><title> Current Listings </title>
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
<h3> Current Listings </h3>
<?php $api->listAllListings(); ?>
<?php 


/*
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
	echo '</table>';*/
?>

</body>
</html>