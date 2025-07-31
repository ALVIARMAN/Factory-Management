<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM Employees');
$employees = [];
while ($row = $result->fetch_assoc()) {
    $employees[] = $row;
}
echo json_encode($employees);
?> 