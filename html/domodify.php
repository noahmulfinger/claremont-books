<?php

	if(isset($_POST['submit'])) {
		$api->modifyBook($_POST[bookid], $_POST[bookTitle], $_POST[bookAuthor], $_POST[bookISBN], $_POST[bookEdition], $_POST[bookBinding]);
		echo '<META HTTP-EQUIV=REFRESH CONTENT="0; '."URL=http://www.claremontbooks.com/books.php".'">';

		exit;
	}
//}

?>