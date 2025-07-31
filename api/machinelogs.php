<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM MachineLogs');
$logs = [];
while ($row = $result->fetch_assoc()) {
    $logs[] = $row;
}
echo json_encode($logs);
?> 