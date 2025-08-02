<?php
$servername = "mysql";
$username = "hamza";
$password = "110022";
$dbname = "movie_management";

// Retry logic: try to connect up to 5 times with a 2-second delay
$max_attempts = 5;
$attempt = 0;
$conn = null;

while ($attempt < $max_attempts) {
    $conn = @new mysqli($servername, $username, $password, $dbname);

    if ($conn && !$conn->connect_error) {
        break;
    }

    error_log("MySQL connection failed (attempt " . ($attempt + 1) . "): " . mysqli_connect_error());
    $attempt++;
    sleep(2);
}

if (!$conn || $conn->connect_error) {
    die("Connection failed after multiple attempts: " . $conn->connect_error);
}
?>
