<?php

/* Some Login tutorials using sessions
http://www.youtube.com/watch?v=u3ry84gg0fw
http://www.youtube.com/watch?v=TuMnH0TXKek
http://www.youtube.com/watch?v=5z0WGE7OkB0
http://www.youtube.com/watch?v=OUiO1hr1kcU
http://www.youtube.com/watch?v=YPh2qJ5zvHg

*/

session_start();
if(isset($_SESSION['user'])) {


?>

<html>
<head>
<title> Admin Area </title>
</head>
<body>

</body>
<html>
<?php
} else {
	header("Location: login.php");
}

?>


