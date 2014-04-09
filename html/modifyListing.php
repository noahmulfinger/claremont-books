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

session_start();

// This is the first thing that gets called when this page is loaded
// Creates a new instance of the Listings class
$api = new Listings;

//get listid variable
$listid = $_POST['listid'];

$api->getBookByListID($listid, $price, $bookid, $title, $author, $isbn, $edition, $binding);

?>

	<h3>Modifying Listing Data</h3>
		<p>Title: <?php echo $title; ?> </p>
		<p>Author: <?php echo $author; ?> </p>
		<p>ISBN: <?php echo $isbn; ?> </p>
		<p>Edition: <?php echo $edition; ?> </p>
		<p>Binding: <?php echo $binding; ?> </p>
		<form action=<?php echo $_SERVER['PHP_SELF']; ?> method="post">
			Price: <input type="text" name="listPrice" value="<?php echo $price ?>"/><br />
			<input type="hidden" name="listid" value="<?php echo $listid; ?>" />
			<input type="submit" name="modify" value="Modify Listing!" />
		</form>

<?php

	//check if submit was pressed
	if(isset($_POST['modify'])) {
		//make sure fields are not empty
		if (isset($_POST['listPrice'])) {
			//add the listing, the current user will be set as the seller
			$api->modifyListing($_POST['listid'], $_POST['listPrice']);
			echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/listings.php".'">';
		}

		exit;
	}


?>