<?php


header('Content-type: application/json');

include 'includes/functions.php';

session_start();

$api = new Listings;

if($_POST) {
	if(isset($_POST['bookid'])) {
		//bookid post so show listings with that book
        $api->listBookListings($_POST['bookid'], 1);

    } else if (isset($_POST['userid'])) {
        //userid posted so show user's books
         $api->listUserListings($_POST['userid'], 1);

    } else {
        //no values posted, so show all listings.
         $api->listAllListings(1);
    }
} else {
    echo "Not accessed using posting.";
}
?>