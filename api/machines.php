<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM Machines');
$machines = [];
while ($row = $result->fetch_assoc()) {
    $machines[] = $row;
}
echo json_encode($machines);
?> 