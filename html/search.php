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

// Check if JSON output is desired
if (isset($_GET['show']) && $_GET['show'] == 'json') {
	$target = $_GET['target'];
	// JSON Usage: http://www.claremontbooks.com/search.php?target=XXX&show=json 
	$api->searchBook($target, 1);

// if not JSON, just regular search, then we have 2 choices
} else {
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
		Omni Search: <input type="text" name="omniSearch" value="" />	
		<input type="submit" name="submit" value="Search!" />
	</form>

	<h3> Current search result of books in database </h3>

	<?php
	// Only display results if user submitted or passed in via URL
	if(isset($_POST['submit'])) {
		$target = $_POST['omniSearch'];
		// Perform search
		$api->searchBook($target, 0);
	} elseif (isset($_GET['target'])) { // Check if anything is passed in via the URL
		$target = $_GET['target'];
		// Perform search
		$api->searchBook($target, 0);
	}
} // end else
?>
	</body>
	</html>