<?php


header('Content-type: application/json');

if($_POST) {
	if(isset($_POST['uemail'])) {
		if(isset($_POST['password'])) {

			$uemail = $_POST['uemail'];
    		$password = $_POST['password'];

    		$user = $api->checkLoginInfo($uemail, $password);

    		if($user != NULL) {
        		$_SESSION['user'] = $user['uid'];

        		echo '{"success":1}';
			} else {
        		echo '{"success":0,"error_message":"Username and/or password is invalid."}';
    		}
		} else {
    		echo '{"success":0,"error_message":"Username and/or password is invalid."}';
		}
	} else {
    	echo '{"success":0,"error_message":"Username and/or password is invalid."}';
	}
} else {
	echo '{"success":0,"error_message":"Username and/or password is invalid."}';
}
?>