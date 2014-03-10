<?php

/*

dologin.php
This file checks to see if the email and password input is valid for login.

*/


include('includes/functions.php');

session_start();

$api = new Users;
//Check if the user has put in login info and check user database for match
if(isset($_POST['login'])) {
	if(isset($_POST['uemail'])) {
		if(isset($_POST['password'])) {

                  $uemail = $_POST['uemail'];
                  $password = $_POST['password'];

                  $user = $api->checkLoginInfo($uemail, $password);

                  if($user != NULL) {
                        $_SESSION['user'] = $user['name'];
                        header("Location: index.php");
                  } else {
                        header("Location: login.php");
                  }

		} else {
                  header("Location: login.php");
            }
	} else {
            header("Location: login.php");
      }
} else {
      header("Location: login.php");
}

?>