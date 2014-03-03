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

class Books {
	private $db;

	// Constructor - opens DB connection
	function __construct() {
		$this->db = new mysqli('mysql.claremontbooks.com', 'cbooks', 'Claremontbooks2014$', 'cbooksdb');
        $this->db->autocommit(FALSE);
  	    if ($mysqli->connect_errno) {
    	   	printf("Connection failed: %s \n", $mysqli->connect_error);
			exit();
		}
    }

    // Destructor - close DB connection
    function __destruct() {
        $this->db->close();
    }

    // Main method to list books
    function listAllBooks() {
        // Print all books in database 
        $stmt = $this->db->prepare('SELECT bookid, title, author, isbn, edition, binding FROM Book ORDER BY bookid');
        $stmt->execute();
        $stmt->bind_result($bookid, $title, $author, $isbn, $edition, $binding);
        $stmt->store_result(); // store result set into buffer

		// Loop through the associative array and output all results.
		if ($stmt->num_rows == 0) 
			echo "No books currently in database!";
		else
		{
			// Print table header
			echo '<table class="booklistings"><tr><th>Book ID</th><th>Title</th><th>Author</th><th>ISBN</th><th>Edition</th><th>Binding</th><th>Modify</th></tr>';
	        
			// Print table data
	        while ($stmt->fetch()) {
		        echo "<tr>";
				echo "<td>$bookid</td>";
				echo "<td>$title</td>";
				echo "<td>$author</td>";
				echo "<td>$isbn</td>";
				echo "<td>$edition</td>";
				echo "<td>$binding</td>";
                echo "<td><form action=\"modify.php\" method=\"post\">
                <input type=\"hidden\" name=\"bookid\" value=\"$bookid\" />
                <input type=\"submit\" name=\"submit\" value=\"Modify!\" />
                </form>";
                echo "<form action=\"delete.php\" method=\"post\">
                <input type=\"hidden\" name=\"bookid\" value=\"$bookid\" />
                <input type=\"submit\" name=\"submit\" value=\"Delete!\" />
                </form></td>";
//				echo "<td><a href=\"modify.php?bookid=$bookid\">Edit</a>&nbsp<a href=\"delete.php?bookid=$bookid\">Delete</a></td>";
				echo "</tr>";
	        }

	        // Close table
        	echo '</table>';
    	}
        $stmt->close();
    } // End list all books

    // Method to list books in JSON format
    function listJSON() {
        // Prepare array to encode json with
        $returnArray = array();
        $returnArray["key"] = "value";  

        $resultjson = $this->db->query('SELECT bookid, title, author, isbn, edition, binding FROM Book ORDER BY bookid');
        
        while ($row = $resultjson->fetch_assoc()) {
             array_push($returnArray, $row);

        }

        echo json_encode($returnArray);
    } // End listJSON

    // Insert books through web form
    function insertBooksWeb($title, $author, $isbn, $edition, $binding) {
        $stmt = $this->db->prepare('INSERT INTO Book (title, author, edition, binding, isbn) VALUES (?, ?, ?, ?, ?)');
        // Replaces the ? above with the variables passed in, i = integer, s = string
        $stmt->bind_param("ssisi", $title, $author, $edition, $binding, $isbn);
        $stmt->execute();

        $stmt->close();
    } // End insertBooksWeb

    // Helper function to Grab book data first based on bookid attribute
    // (all attributes except bookid is passed in by reference)
    function grabCurrentBook($bookid, &$title, &$author, &$isbn, &$edition, &$binding) {
    	$stmt = $this->db->prepare('SELECT bookid, title, author, isbn, edition, binding FROM Book WHERE bookid = ?');
        $stmt->bind_param("i", $bookid);
    	$stmt->execute();
        $stmt->bind_result($bookid, $title, $author, $isbn, $edition, $binding);
        $stmt->store_result(); // store result set into buffer
        $stmt->fetch(); //fetch the result into variables
        
        $stmt->close();
    }

    // Modify a Book 
    function modifyBook($bookid, $title, $author, $isbn, $edition, $binding) {
        // Prepare update modified book variables
        $stmt = $this->db->prepare('UPDATE Book SET title=?, author=?, isbn=?, edition=?, binding=? WHERE bookid=?');
        $stmt->bind_param("ssiisi", $title, $author, $isbn, $edition, $binding, $bookid);
        $stmt->execute();

        $stmt->close();
    }

    // Delete a book
    function deleteBook($bookid) {
        // Prepare delete statement
        $stmt = $this->db->prepare('DELETE FROM Book WHERE bookid=?');
        $stmt->bind_param("i", $bookid);
        $stmt->execute();

        $stmt->close();
    }

    // Search for a book
    function searchBook($target) {
        // $stmt = $this->db->prepare('SELECT bookid, title, author, isbn, edition, binding FROM Book WHERE (bookid LIKE $target OR title LIKE $target OR author LIKE $target OR isbn LIKE $target OR edition LIKE $target OR binding LIKE $target)');
        $stmt = $this->db->prepare('SELECT bookid, title, author, isbn, edition, binding FROM Book WHERE (title LIKE %?%) ORDER BY bookid');
        
        $stmt->bind_param("s", $target);
        //$stmt->bind_param("issiis", $target, $target, $target, $target, $target, $target);
        $stmt->bind_result($bookid, $title, $author, $isbn, $edition, $binding);
        $stmt->store_result(); // Store result set into buffer
        $stmt->execute();

        // Loop through the associative array and output all results.
        if ($stmt->num_rows == 0) 
            echo "No books currently match your search query!";
        else
        {
            // Print table header
            echo '<table class="booklistings"><tr><th>Book ID</th><th>Title</th><th>Author</th><th>ISBN</th><th>Edition</th><th>Binding</th><th>Modify</th></tr>';
            
            // Print table data
            while ($stmt->fetch()) {
                echo "<tr>";
                echo "<td>$bookid</td>";
                echo "<td>$title</td>";
                echo "<td>$author</td>";
                echo "<td>$isbn</td>";
                echo "<td>$edition</td>";
                echo "<td>$binding</td>";
                echo "<td><form action=\"modify.php\" method=\"post\">
                <input type=\"hidden\" name=\"bookid\" value=\"$bookid\" />
                <input type=\"submit\" name=\"submit\" value=\"Modify!\" />
                </form>";
                echo "<form action=\"delete.php\" method=\"post\">
                <input type=\"hidden\" name=\"bookid\" value=\"$bookid\" />
                <input type=\"submit\" name=\"submit\" value=\"Delete!\" />
                </form></td>";
//              echo "<td><a href=\"modify.php?bookid=$bookid\">Edit</a>&nbsp<a href=\"delete.php?bookid=$bookid\">Delete</a></td>";
                echo "</tr>";
            }

            // Close table
            echo '</table>';
        }
        $stmt->close();
    } // End Searchbook

} // End Books class

class Listings {
	private $db;

	// Constructor - opens DB connection
	function __construct() {
		$this->db = new mysqli('mysql.claremontbooks.com', 'cbooks', 'Claremontbooks2014$', 'cbooksdb');
        $this->db->autocommit(FALSE);
  	    if ($mysqli->connect_errno) {
    	   	printf("Connection failed: %s \n", $mysqli->connect_error);
			exit();
		}
    }

    // Destructor - close DB connection
    function __destruct() {
        $this->db->close();
    }

	// Main method to list listings
    function listAllListings() {
        // Print all books in database
        $stmt = $this->db->prepare('SELECT L.listid, B.title, B.author, B.edition, L.price, U.name FROM Listings L, Book B, Users U WHERE (L.bookid = B.bookid AND L.sellerid = U.uid) ORDER BY listid');
        $stmt->execute();
        $stmt->bind_result($listid, $title, $author, $edition, $price, $sellername);
        $stmt->store_result(); // store result set into buffer
        
		// Loop through the associative array and output all results.
		if ($stmt->num_rows == 0) 
			echo "No active listings!";
		else
		{
			// Print table header
			echo '<table class="listinglistings"><tr><th>List ID</th><th>Title</th><th>Author</th><th>Edition</th><th>Price</th><th>Seller Name</th><th>Modify?</th></tr>';
	        
			// Print table data
	        while ($stmt->fetch()) {
		        echo "<tr>";
				echo "<td>$listid</td>";
				echo "<td>$title</td>";
				echo "<td>$author</td>";
				echo "<td>$edition</td>";
				echo "<td>$price</td>";
				echo "<td>$sellername</td>";
				echo "<td><a href=\"modify.php?bookid=$bookid\"> Edit</a>&nbsp<a href=\"delete.php?bookid=$bookid\">Delete</a></td>";
				echo "</tr>";
	        }

	        // Close table
        	echo '</table>';
    	}
        $stmt->close();
    }
} // End Listings class

?>