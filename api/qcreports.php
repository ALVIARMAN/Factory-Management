<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM QCReports');
$qc = [];
while ($row = $result->fetch_assoc()) {
    $qc[] = $row;
}
echo json_encode($qc);
?> 