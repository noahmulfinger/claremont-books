<?php
/*
 * Claremont Books: Main page
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 */

session_start();

if(isset($_SESSION['user'])) {
?>

<html>
<head><title> Claremont books is coming soon </title>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48321922-1', 'claremontbooks.com');
  ga('send', 'pageview');

</script>
<link rel="stylesheet" type="text/css" media="all" href="style.css" />
</head>

<body>


<h3> Current beta pages </h3>
<a href="listings.php" target="_self">Show current listings</a> <br />

<a href="books.php" target="_self">Show current books</a> <br />

<form action = "logout.php" method="link">
<input type="submit" VALUE="Logout">
</form>
</body>
</html>

<?php
} else {
	header("Location: login.php");
}

?>

