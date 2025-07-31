<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

$result = $conn->query('SELECT * FROM Sell');
$sells = [];
while ($row = $result->fetch_assoc()) {
    $sells[] = $row;
}
echo json_encode($sells);
?>
