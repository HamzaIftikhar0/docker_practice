<?php
$servername = "mysql";  // matches extra_hosts mapping in docker-compose.yml
$username = "hamza";
$password = "110022";            // your MySQL root password
$dbname = "movie_management";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>
