<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM Parts');
$parts = [];
while ($row = $result->fetch_assoc()) {
    $parts[] = $row;
}
echo json_encode($parts);
?> 