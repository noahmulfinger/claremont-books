<?php 
/*
 * Claremont test file for converting between old mysql to new mysqli extension
 * Class: CS121
 * Project: Claremont Books App
 * 
 * Authors: Bruce Yan
 * E-mail: byan@hmc.edu
 * 
 */

include 'includes/functions.php';

// This is the first thing that gets called when this page is loaded
// Creates a new instance of the testBooks class and calls the hello method
$api = new testBooks;
$api->hello();

?>
<html>
<head><title> Current Books </title>
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

<h3> Current books in database </h3>

<?php $api->listAllBooks(); ?>

</body>
</html>
