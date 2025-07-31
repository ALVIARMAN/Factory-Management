<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM DowntimeLogs');
$downtime = [];
while ($row = $result->fetch_assoc()) {
    $downtime[] = $row;
}
echo json_encode($downtime);
?> 