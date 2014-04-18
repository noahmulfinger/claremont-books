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

	//check if submit was pressed
if($_POST) {
		//make sure fields are not empty
	if (isset($_POST['listid']) && isset($_POST['listPrice'])) {
		//change the listing, the current user will be set as the seller
		$api->modifyListing($_POST['listid'], $_POST['listPrice']);
		echo '{"success":1}';

	} else {
		echo '{"success":0,"error_message":"One or more entries was not set correctly."}';
	}
} else {
	echo '{"success":0,"error_message":"This page was not accessed via posting."}';
}

?>