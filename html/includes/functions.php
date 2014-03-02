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

	// $dbhost = 'mysql.claremontbooks.com';
	// $dbuser = 'cbooks';
	// $dbpass = 'Claremontbooks2014$';
	// $dbname = 'cbooksdb';

	// // Initiate connection to server
	// $conn = mysql_connect($dbhost, $dbuser, $dbpass);

	// // Select the database to operate on
	// mysql_select_db($dbname);

// $mysql_server = "localhost";
// $mysql_user = "root";
// $mysql_password = "";
// $mysql_db = "";
// $mysqli = new mysqli($mysql_server, $mysql_user, $mysql_password, $mysql_db);
// if ($mysqli->connect_errno) {
// 	printf("Connection failed: %s \n", $mysqli->connect_error);
// 	exit();
// }
// $mysqli->set_charset("utf8");


class testBooks {
	private $db;

	// Constructor - opens DB connection
	function __construct() {
		$this->db = new mysqli('mysql.claremontbooks.com', 'cbooks', 'Claremontbooks2014$', 'cbooksdb');
        $this->db->autocommit(FALSE);
  //       if ($mysqli->connect_errno) {
  //       	printf("Connection failed: %s \n", $mysqli->connect_error);
		// exit();
		// }
		// $mysqli->set_charset("utf8");

    }

    // Destructor - close DB connection
    function __destruct() {
        $this->db->close();
    }

    // Main method to redeem a code
    function listAllBooks() {
        // Print all books in database 
        $stmt = $this->db->prepare('SELECT bookid, title, author, isbn, edition, binding FROM Book ORDER BY bookid');
        $stmt->execute();
        $stmt->bind_result($bookid, $title, $author, $isbn, $edition, $binding);
        echo '<table style="width:600px">
		<tr>
		  <th>Book ID</th>
		  <th>Title</th> 
		  <th>Author</th>
		  <th>ISBN</th>
		  <th>Edition</th>
		  <th>Binding</th>
		  <th>Modify</th>
		</tr>';
        while ($stmt->fetch()) {
            //echo "$bookid and $title!";

	        echo "<tr>";
			echo "<td>$bookid</td>";
			echo "<td>$title</td>";
			echo "<td>$author</td>";
			echo "<td>$isbn</td>";
			echo "<td>$edition</td>";
			echo "<td>$binding</td>";
			echo "<td><a href=\"modify.php?bookid=$bookid\"> Edit</a>&nbsp<a href=\"delete.php?bookid=$bookid\"> Delete</a></td>";
			echo "</tr>";
        }
        echo '</table';
        $stmt->close();
    }

	// main method for testing
	function hello() {
		echo "Hello, PHP!";
	}
}





?>