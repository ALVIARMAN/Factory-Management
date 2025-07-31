<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM WorkOrders');
$workorders = [];
while ($row = $result->fetch_assoc()) {
    $workorders[] = $row;
}
echo json_encode($workorders);
?> 