<?php
header('Content-Type: application/json');
require 'ManufacturingSystem.php';

// Get all sales
$sales = [];
$result = $conn->query('SELECT * FROM Sell');
while ($row = $result->fetch_assoc()) {
    $sales[] = $row;
}

$profits = [];
foreach ($sales as $sale) {
    $cost = 0;
    // Find cost for product or part
    if ($sale['product_id']) {
        $costResult = $conn->query("SELECT amount FROM Costs WHERE product_id = {$sale['product_id']} ORDER BY cost_date DESC LIMIT 1");
        if ($costResult && $costRow = $costResult->fetch_assoc()) {
            $cost = $costRow['amount'];
        }
    } elseif ($sale['part_id']) {
        $costResult = $conn->query("SELECT amount FROM Costs WHERE part_id = {$sale['part_id']} ORDER BY cost_date DESC LIMIT 1");
        if ($costResult && $costRow = $costResult->fetch_assoc()) {
            $cost = $costRow['amount'];
        }
    }
    $total_cost = $cost * $sale['quantity'];
    $total_revenue = $sale['sell_price'] * $sale['quantity'];
    $profit = $total_revenue - $total_cost;
    $profits[] = [
        'sell_id' => $sale['sell_id'],
        'product_id' => $sale['product_id'],
        'part_id' => $sale['part_id'],
        'quantity' => $sale['quantity'],
        'sell_price' => $sale['sell_price'],
        'cost_per_unit' => $cost,
        'total_revenue' => $total_revenue,
        'total_cost' => $total_cost,
        'profit' => $profit,
        'sell_date' => $sale['sell_date']
    ];
}

echo json_encode($profits);
?>
