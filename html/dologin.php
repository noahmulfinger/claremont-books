<?php

/*

dologin.php
This file checks to see if the email and password input is valid for login.

*/


include('includes/functions.php')

//Check if the user has put in login info and check user database for match
if(isset($_POST['Login'])) {
	if($_POST['uemail']) {
		if($_POST['password']) {
			$stmt = $this->db->prepare('SELECT * FROM Users WHERE uemail =mysql_real_escape_string($_POST['uemail'])');
            //$stmt->bind_param("s", $target);
            $stmt->execute();
            $stmt->bind_result($user)
            //$stmt->store_result();

            if($_POST['password'] == $user['password']) {
            	echo "Login successful";
            }

		}
	}
}

?>