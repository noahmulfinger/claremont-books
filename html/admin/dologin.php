<?php

/*

dologin.php
This file checks to see if the email and password input is valid for login.

*/


include('../includes/functions.php');

$api = new Users;
//Check if the user has put in login info and check user database for match
if(isset($_POST['submit'])) {
	if($_POST['uemail']) {
		if($_POST['password']) {

                  $uemail = $_POST['uemail'];
                  $password = $_POST['password'];

                  $api->checkLoginInfo($uemail, $password);

			//$stmt = $this->db->prepare('SELECT * FROM Users WHERE uemail =mysql_real_escape_string($uemail)');
                  //$stmt->bind_param("s", $target);
                  //$stmt->execute();
                  //$stmt->bind_result($user);
                  //$stmt->store_result();

                  //if(md5($_POST['password']) == $user['password']) {
                  //	echo "Login successful";
                  //}

		}
	}
}

?>