<?php
$servername = "localhost";
$database = "libreria";

$conn = new mysqli($servername, 'root', '', $database);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Verificar si los campos POST están presentes
if (isset($_POST['titulo']) && isset($_POST['autor']) && isset($_FILES['imagen']) && isset($_POST['editorial']) && isset($_POST['paginas']) && isset($_POST['anio']) && isset($_POST['genero'])) {
  $titulo = $_POST['titulo'];
  $autor = $_POST['autor'];
  $editorial = $_POST['editorial'];
  $paginas = $_POST['paginas'];
  $anio = $_POST['anio'];
  $genero = $_POST['genero'];

  $imagen = $_FILES['imagen']['name'];
  $target_dir = "image_upload_php_mysql/";
  $target_file = $target_dir . basename($_FILES["imagen"]["name"]);

  // Verificar si se subió correctamente el archivo
  if (isset($_FILES["imagen"]["tmp_name"]) && move_uploaded_file($_FILES["imagen"]["tmp_name"], $target_file)) {
    $sql = "INSERT INTO books (titulo, autor, editorial, paginas, anio, genero, imagen) VALUES ('$titulo', '$autor', '$editorial', '$paginas', '$anio', '$genero', '$imagen')";
    if ($conn->query($sql) === TRUE) {
      echo "New record created successfully";
    } else {
      echo "Error: " . $sql . "" . $conn->error;
    }
  } else {
    echo "Error uploading image";
  }
} else {
  echo "Error: Missing POST fields";
}

$conn->close();
?>
