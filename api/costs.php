<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM Costs');
$costs = [];
while ($row = $result->fetch_assoc()) {
    $costs[] = $row;
}
echo json_encode($costs);
?> 