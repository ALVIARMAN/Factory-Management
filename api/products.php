<?php
header("Content-Type: application/json");
require "ManufacturingSystem.php";

$result = $conn->query("SELECT * FROM Products");
$products = [];
while ($row = $result->fetch_assoc()) {
    $products[] = $row;
}
echo json_encode($products);
?>
