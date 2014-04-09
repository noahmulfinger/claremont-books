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
    function listAllBooks($json) {
        // Print all books in database 
        $stmt = $this->db->prepare('SELECT bookid, title, author, isbn, edition, binding FROM Book ORDER BY bookid');
        $stmt->execute();
        $stmt->bind_result($bookid, $title, $author, $isbn, $edition, $binding);
        $stmt->store_result(); // store result set into buffer

        // JSON variables - prepare array to encode JSON with
        $outerArray = array();

        // Push the results into JSON format if requested
        if ($json == 1) {
            // Loop through each statement to grab columns and data
            while ($stmt->fetch()) {
                $loopArray = array('bookid' => $bookid, 'title' => $title, 'author' => $author, 'isbn' => $isbn, 'edition' => $edition, 'binding' => $binding);
                array_push($outerArray, $loopArray);
            }

            $returnArray = array("books" => $outerArray);

            echo json_encode($returnArray);
            exit;
        }

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
                <input type=\"hidden\" name=\"listing\" value=\"0\" />
                <input type=\"submit\" name=\"submit\" value=\"Modify!\" />
                </form>";
                echo "<form action=\"delete.php\" method=\"post\">
                <input type=\"hidden\" name=\"bookid\" value=\"$bookid\" />
                <input type=\"submit\" name=\"submit\" value=\"Delete!\" />
                </form>";
                echo "<form action=\"addListing.php\" method=\"post\">
                <input type=\"hidden\" name=\"bookid\" value=\"$bookid\" />
                <input type=\"submit\" name=\"add\" value=\"Add Listing!\" />
                </form></td>";
//				echo "<td><a href=\"modify.php?bookid=$bookid\">Edit</a>&nbsp<a href=\"delete.php?bookid=$bookid\">Delete</a></td>";
				echo "</tr>";
	        }

	        // Close table
        	echo '</table>';
    	}
        $stmt->close();
    } // End list all books

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
    function getBookByID($bookid, &$title, &$author, &$isbn, &$edition, &$binding) {
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
    function searchBook($target, $json) {
        // Check to ensure something was entered;
        if ($target == "")
            echo "Enter a search term!";
        else {
            // add wild cards into search term
            $likeTarget = '%' . $target . '%';
            $stmt = $this->db->prepare('SELECT bookid, title, author, isbn, edition, binding FROM Book WHERE (bookid LIKE ? OR title LIKE ? OR author LIKE ? OR isbn LIKE ? OR edition LIKE ? OR binding LIKE ?)');
            $stmt->bind_param("issiis", $likeTarget, $likeTarget, $likeTarget, $likeTarget, $likeTarget, $likeTarget);
            $stmt->execute();
            $stmt->bind_result($bookid, $title, $author, $isbn, $edition, $binding);
            $stmt->store_result(); // Store result set into buffer
            
            // JSON variables - prepare array to encode JSON with
            $outerArray = array();

            // Push the results into JSON format if requested
            if ($json == 1) {
                // Loop through each statement to grab columns and data
                while ($stmt->fetch()) {
                    $loopArray = array('bookid' => $bookid, 'title' => $title, 'author' => $author, 'isbn' => $isbn, 'edition' => $edition, 'binding' => $binding);
                    array_push($outerArray, $loopArray);
                }

                $returnArray = array("books" => $outerArray);

                echo json_encode($returnArray);
                exit;
            }

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
                    echo "</tr>";
                }

                // Close table
                echo '</table>';
            }
            $stmt->close();
        } // End Check for empty search string
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

    function getBookByListID($listid, &$price, &$bookid, &$title, &$author, &$isbn, &$edition, &$binding) {
        $stmt = $this->db->prepare('SELECT listid, bookid, price FROM Listings WHERE listid = ?');
        $stmt->bind_param("i", $listid);
        $stmt->execute();
        $stmt->bind_result($listid, $bookid, $price);
        $stmt->store_result(); // store result set into buffer
        $stmt->fetch(); //fetch the result into variables
        
        $stmt->close();

        $api = new Books;

        $api->getBookByID($bookid, $title, $author, $isbn, $edition, $binding);
    }
    

    function addListing($bookid, $price, $userid) {
        $stmt = $this->db->prepare('INSERT INTO Listings (bookid, price, sellerid) VALUES (?, ?, ?)');
        // Replaces the ? above with the variables passed in, i = integer, s = string
        $stmt->bind_param("iii", $bookid, $price, $userid);
        $stmt->execute();

        $stmt->close();
    }

    function modifyListing($listid, $price) {
        $stmt = $this->db->prepare('UPDATE Listings SET price=? WHERE listid=?');
        // Replaces the ? above with the variables passed in, i = integer, s = string
        $stmt->bind_param("ii", $price, $listid);
        $stmt->execute();

        $stmt->close();
    }

    // Delete a listing
    function deleteListing($listid) {
        // Prepare delete statement
        $stmt = $this->db->prepare('DELETE FROM Listings WHERE listid = ?');
        $stmt->bind_param("i", $listid);
        $stmt->execute();

        $stmt->close();
    }
	// Main method to list all listings
    function listAllListings($json) {
        // Print all listings in database
        $stmt = $this->db->prepare('SELECT L.listid, B.title, B.author, B.edition, L.price, U.name FROM Listings L, Book B, Users U WHERE (B.bookid = L.bookid AND U.uid = L.sellerid) ORDER BY L.listid');
        
        //send listings to be displayed on web or sent to app
		$this->outputListings($stmt, $json);

        $stmt->close();
    }

    //function that lists listings based on current user
    function listUsersListings($userid, $json) {
        // Access listing information for current user's listings in database
        $stmt = $this->db->prepare('SELECT L.listid, B.title, B.author, B.edition, L.price, U.name FROM Listings L, Book B, Users U WHERE (B.bookid = L.bookid AND U.uid = L.sellerid AND U.uid = ?) ORDER BY L.listid');
        $stmt->bind_param("i", $userid);
        
        //send listings to be displayed on web or sent to app
        $this->outputListings($stmt, $json);

        $stmt->close();
    }

     //function that lists listings based on current user
    function listBookListings($bookid, $json) {
        // Access listing information for current user's listings in database
        $stmt = $this->db->prepare('SELECT L.listid, B.title, B.author, B.edition, L.price, U.name  FROM Listings L, Book B, Users U WHERE (B.bookid = L.bookid AND U.uid = L.sellerid AND B.bookid = ?) ORDER BY L.listid');
        $stmt->bind_param("i", $bookid);
        
        //send listings to be displayed on web or sent to app
        $this->outputListings($stmt, $json);

        $stmt->close();
    }

    function outputListings($stmt, $json) {

        $stmt->execute();
        $stmt->bind_result($listid, $title, $author, $edition, $price, $sellerName);
        $stmt->store_result(); // store result set into buffer
         //check if accessed by website or app
        if ($json == 1) {

            $outerArray = array();

            // Loop through each statement to grab columns and data
                while ($stmt->fetch()) {
                    $loopArray = array('listid' => $listid, 'title' => $title, 'author' => $author, 'edition' => $edition, 'price' => $price, 'sellername' => $sellerName);
                    array_push($outerArray, $loopArray);
                }

                $returnArray = array("listings" => $outerArray);

                echo json_encode($returnArray);
                exit;

        } else {
            // Loop through the associative array and output all results.
            if ($stmt->num_rows == 0) {
                echo "No active listings!";

            } else {
                // Print table header
                echo '<table class="listinglistings"><tr><th>List ID</th><th>Title</th><th>Author</th><th>Edition</th><th>Price</th><th>Seller Name</th><th>Modify?</th></tr>';
                
                // Print table data
                while ($stmt->fetch()) {
                    echo "<tr>";
                    echo "<td>$listid</td>";
                    echo "<td>$title</td>";
                    echo "<td>$author</td>";
                    echo "<td>$edition</td>";
                    echo "<td>$$price</td>"; //Extra $ for price, don't delete
                    echo "<td>$sellerName</td>";
                    echo "<td><form action=\"modifyListing.php\" method=\"post\">
                    <input type=\"hidden\" name=\"listid\" value=\"$listid\" />
                    <input type=\"submit\" name=\"submit\" value=\"Modify!\" />
                    </form>";
                    echo "<form action=\"deleteListing.php\" method=\"post\">
                    <input type=\"hidden\" name=\"listid\" value=\"$listid\" />
                    <input type=\"submit\" name=\"submit\" value=\"Delete!\" />
                    </form></td>";
                    echo "</tr>";
                }
                // Close table
                echo '</table>';
            }
        }
    }


} // End Listings class

class Users {
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

     // Check if the user input valid login information
    function checkLoginInfo($inputEmail, $inputPassword) {
        // Prepare to access
        $inputEmail = $this->db->escape_string($inputEmail);
        $inputPassword = hash('sha256', ($this->db->escape_string($inputPassword)));
       
        // Search for matching email and password in database
        $stmt = $this->db->prepare('SELECT uid, name, uemail, password FROM Users WHERE uemail = ? AND password = ?');
        $stmt->bind_param("ss", $inputEmail, $inputPassword);
        $stmt->execute();
        $stmt->bind_result($userid, $name, $uemail, $password);
        $stmt->fetch();


        if($inputPassword == $password) {
            return array('uid'=>$userid, 'name'=>$name, 'email'=>$uemail, 'password'=>$password);
        } else {
            return NULL;
        }
    }

}

?>