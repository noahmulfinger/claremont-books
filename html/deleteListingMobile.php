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

// This is the first thing that gets called when this page is loaded
// Creates a new instance of the Books class
$api = new Listings;

if ($_POST) {
	if($_POST['listid']) {
		$listid = $_POST['listid'];
		
		$api->deleteListing($listid);

		echo '{"success":1}';

	} else {
		echo '{"success":0,"error_message":"One or more entries was not set correctly."}';
	}
} else {
	echo '{"success":0,"error_message":"This page was not accessed via posting."}';
}
	
?>