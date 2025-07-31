function filterTableRows(inputId, tableBodyId) {
  const filter = document.getElementById(inputId).value.toLowerCase();
  const rows = document.getElementById(tableBodyId).getElementsByTagName('tr');
  for (let i = 0; i < rows.length; i++) {
    const rowText = rows[i].textContent.toLowerCase();
    rows[i].style.display = rowText.includes(filter) ? '' : 'none';
  }
}

document.getElementById('global-search').addEventListener('input', function() {
  filterTableRows('global-search', 'product-list');
  filterTableRows('global-search', 'machine-list');
  filterTableRows('global-search', 'employee-list');
  filterTableRows('global-search', 'workorder-list');
});

// Fetch and display Products
fetch('/FactoryManage/api/products.php')
  .then(res => res.json())
  .then(products => {
    const tbody = document.getElementById('product-list');
    products.forEach(p => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${p.product_id}</td><td>${p.name}</td><td>${p.category}</td><td>${p.description}</td>`;
      tbody.appendChild(tr);
    });
  });

// Fetch and display Machines
fetch('/FactoryManage/api/machines.php')
  .then(res => res.json())
  .then(machines => {
    const tbody = document.getElementById('machine-list');
    machines.forEach(m => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${m.name}</td><td>${m.model}</td><td>${m.status}</td><td>${m.last_maintenance}</td>`;
      tbody.appendChild(tr);
    });
  });

// Fetch and display Machine Usage Logs
fetch('/FactoryManage/api/machinelogs.php')
  .then(res => res.json())
  .then(logs => {
    const tbody = document.getElementById('machinelogs-list');
    logs.forEach(l => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${l.machine_id}</td><td>${l.emp_id}</td><td>${l.work_order_id}</td><td>${l.usage_start || ''}</td><td>${l.usage_end || ''}</td>`;
      tbody.appendChild(tr);
    });
  });  

// Fetch and display Employees
fetch('/FactoryManage/api/employees.php')
  .then(res => res.json())
  .then(employees => {
    const tbody = document.getElementById('employee-list');
    employees.forEach(e => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${e.emp_id}</td><td>${e.name}</td><td>${e.role}</td><td>${e.shift}</td>`;
      tbody.appendChild(tr);
    });
  });

// Fetch and display Work Orders
fetch('/FactoryManage/api/workorders.php')
  .then(res => res.json())
  .then(workorders => {
    const tbody = document.getElementById('workorder-list');
    workorders.forEach(w => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${w.work_order_id}</td><td>${w.product_id}</td><td>${w.machine_id}</td><td>${w.start_date || ''}</td><td>${w.end_date || ''}</td><td>${w.status}</td>`;
      tbody.appendChild(tr);
    });
  });

// Fetch and display Parts
fetch('/FactoryManage/api/parts.php')
  .then(res => res.json())
  .then(parts => {
    const tbody = document.getElementById('parts-list');
    parts.forEach(p => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${p.part_id}</td><td>${p.part_name}</td><td>${p.part_type}</td><td>${p.stock_quantity}</td>`;
      tbody.appendChild(tr);
    });
  });

// Fetch and display Costs
fetch('/FactoryManage/api/costs.php')
  .then(res => res.json())
  .then(costs => {
    const tbody = document.getElementById('costs-list');
    costs.forEach(c => {
      tr = document.createElement('tr');
      tr.innerHTML = `<td>${c.cost_type}</td><td>${c.amount}</td><td>${c.cost_date || ''}</td><td>${c.notes || ''}</td>`;
      tbody.appendChild(tr);
    });
  });



// Fetch and display QC Reports
fetch('/FactoryManage/api/qcreports.php')
  .then(res => res.json())
  .then(qc => {
    const tbody = document.getElementById('qcreports-list');
    qc.forEach(r => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${r.work_order_id}</td><td>${r.inspector_id}</td><td>${r.inspection_date || ''}</td><td>${r.passed ? 'Yes' : 'No'}</td><td>${r.defects_found}</td><td>${r.notes || ''}</td>`;
      tbody.appendChild(tr);
    });
  });

// Fetch and display Downtime Logs
fetch('/FactoryManage/api/downtimelogs.php')
  .then(res => res.json())
  .then(downtime => {
    const tbody = document.getElementById('downtimelogs-list');
    downtime.forEach(d => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${d.machine_id}</td><td>${d.start_time || ''}</td><td>${d.end_time || ''}</td><td>${d.reason || ''}</td>`;
      tbody.appendChild(tr);
    });
  });

// Fetch and display Sell
fetch('/FactoryManage/api/sell.php')
  .then(res => res.json())
  .then(sells => {
    const tbody = document.getElementById('sell-list');
    sells.forEach(s => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${s.product_id || ''}</td><td>${s.part_id || ''}</td><td>${s.quantity}</td><td>${s.sell_price}</td><td>${s.sell_date || ''}</td>`;
      tbody.appendChild(tr);
    });
  });

// Fetch and display Profits
fetch('/FactoryManage/api/profits.php')
  .then(res => res.json())
  .then(profits => {
    const tbody = document.getElementById('profits-list');
    let totalProfit = 0;
    profits.forEach(p => {
      totalProfit += parseFloat(p.profit);
      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td>${p.product_id || ''}</td>
        <td>${p.part_id || ''}</td>
        <td>${p.quantity}</td>
        <td>${parseFloat(p.sell_price).toFixed(2)}</td>
        <td>${parseFloat(p.cost_per_unit).toFixed(2)}</td>
        <td>${parseFloat(p.total_revenue).toFixed(2)}</td>
        <td>${parseFloat(p.total_cost).toFixed(2)}</td>
        <td>${parseFloat(p.profit).toFixed(2)}</td>
        <td>${p.sell_date || ''}</td>
      `;
      tbody.appendChild(tr);
    });
    document.getElementById('profit-summary').innerHTML =
      `<strong>Total Profit: </strong> <span style=\"color: #27ae60; font-size: 1.3em; font-weight: bold;\">$${totalProfit.toFixed(2)}</span>`;
  });
