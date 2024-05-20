<?php

$servername = "localhost";
$database = "libreria";

$conn = new mysqli($servername, 'root', '', $database);

if ($conn->connect_error) {
  die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

$sql = "SELECT * FROM books";
$result = $conn->query($sql);

$books = array();
if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $books[] = $row;
  }
  echo json_encode($books);
} else {
  echo json_encode(["error" => "No books found"]);
}

$conn->close();
?>
