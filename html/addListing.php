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

// Grab bookid variable from URL
$bookid = $_POST['bookid'];
$title = $_POST['title'];
$author = $_POST['author'];
$isbn = $_POST['isbn'];
$edition = $_POST['edition'];
$binding = $_POST['binding'];

?>

<h3> Adding Listing </h3>
	<p>Title: <?php echo $title; ?> </p>
	<p>Author: <?php echo $author; ?> </p>
	<p>ISBN: <?php echo $isbn; ?> </p>
	<p>Edition: <?php echo $edition; ?> </p>
	<p>Binding: <?php echo $binding; ?> </p>
	<form action=<?php echo $_SERVER['PHP_SELF']; ?> method="post">
		Quantity: <input type="text" name="quantity"  /><br />
		Price: <input type="text" name="price" /><br />
		<input type="hidden" name="bookid" value="<?php echo $bookid; ?>" />
		<input type="submit" name="submit" value="Add Listing!" />
	</form>

<?php
//check if submit was pressed
if(isset($_POST['submit'])) {
	//make sure fields are not empty
	if (isset($_POST['price']) && isset($_POST['quantity'])) {
		//add the listing, the current user will be set as the seller
		$api->addListing($bookid, $_POST['quantity'], $_POST['price'], $_SESSION['user']);
		echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/listings.php".'">';
	}

	exit;
}

?>