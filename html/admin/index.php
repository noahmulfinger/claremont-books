

<!--
 Some Login tutorials using sessions
http://www.youtube.com/watch?v=u3ry84gg0fw
http://www.youtube.com/watch?v=TuMnH0TXKek
http://www.youtube.com/watch?v=5z0WGE7OkB0
http://www.youtube.com/watch?v=OUiO1hr1kcU
http://www.youtube.com/watch?v=YPh2qJ5zvHg
-->




<html>
<head>
<title> Admin Area </title>
</head>
<body>

<?php
session_start();
if(isset($_SESSION['user'])) {
?>

<span>Currently logged in as <?php echo $_SESSION['user']; ?> </span> 

<form action = "logout.php" method="link">
<input type="submit" VALUE="Logout">
</form>

</body>
<html>
<?php
} else {
	header("Location: login.php");
}

?>


