-- Create and use the database
CREATE DATABASE ManufacturingSystem;
USE ManufacturingSystem;

-- 1. Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    description TEXT
);

-- 2. Parts & Materials
CREATE TABLE Parts (
    part_id INT AUTO_INCREMENT PRIMARY KEY,
    part_name VARCHAR(100),
    part_type VARCHAR(50),
    stock_quantity INT
);

-- 3. Machines
CREATE TABLE Machines (
    machine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    model VARCHAR(50),
    status ENUM('Running', 'Idle', 'Maintenance'),
    last_maintenance DATE
);

-- 4. Employees
CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    shift ENUM('Morning', 'Evening', 'Night')
);

-- 5. Work Orders
CREATE TABLE WorkOrders (
    work_order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    machine_id INT,
    start_date DATE,
    end_date DATE,
    status ENUM('Pending', 'In Progress', 'Completed', 'Cancelled'),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (machine_id) REFERENCES Machines(machine_id)
);

-- 6. Machine Usage Logs
CREATE TABLE MachineLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    machine_id INT,
    emp_id INT,
    work_order_id INT,
    usage_start DATETIME,
    usage_end DATETIME,
    FOREIGN KEY (machine_id) REFERENCES Machines(machine_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (work_order_id) REFERENCES WorkOrders(work_order_id)
);

-- 7. Quality Control Reports
CREATE TABLE QCReports (
    qc_id INT AUTO_INCREMENT PRIMARY KEY,
    work_order_id INT,
    inspector_id INT,
    inspection_date DATE,
    passed BOOLEAN,
    defects_found INT,
    notes TEXT,
    FOREIGN KEY (work_order_id) REFERENCES WorkOrders(work_order_id),
    FOREIGN KEY (inspector_id) REFERENCES Employees(emp_id)
);

-- 8. Downtime Logs
CREATE TABLE DowntimeLogs (
    downtime_id INT AUTO_INCREMENT PRIMARY KEY,
    machine_id INT,
    start_time DATETIME,
    end_time DATETIME,
    reason TEXT,
    FOREIGN KEY (machine_id) REFERENCES Machines(machine_id)
);

-- 9. Costs
CREATE TABLE Costs (
    cost_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    part_id INT,
    machine_id INT,
    emp_id INT,
    cost_type ENUM('Product', 'Material', 'Machine', 'Employee'),
    amount DECIMAL(12,2) NOT NULL,
    cost_date DATE,
    notes TEXT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (part_id) REFERENCES Parts(part_id),
    FOREIGN KEY (machine_id) REFERENCES Machines(machine_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

-- 10. Sell Table
CREATE TABLE Sell (
    sell_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    part_id INT,
    quantity INT NOT NULL,
    sell_price DECIMAL(12,2) NOT NULL,
    sell_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (part_id) REFERENCES Parts(part_id)
);

-- ======================
-- Sample Data Insertion
-- ======================

-- Products
INSERT INTO Products (name, category, description) VALUES
('Smartphone X1', 'Smartphone', 'Flagship smartphone with OLED display.'),
('Smartphone X1 Mini', 'Smartphone', 'Compact version of X1 with LCD display.'),
('Smartphone Pro Max', 'Smartphone', 'High-end smartphone with triple camera.');

-- Parts
INSERT INTO Parts (part_name, part_type, stock_quantity) VALUES
('Screw', 'Fastener', 500),
('Bolt', 'Fastener', 300),
('Gear', 'Mechanical', 150),
('OLED Display', 'Screen', 200),
('LCD Display', 'Screen', 300),
('Battery 4000mAh', 'Battery', 500),
('Triple Camera Module', 'Camera', 150),
('Aluminum Frame', 'Body', 400),
('Motherboard v2', 'Electronics', 250);

-- Machines
INSERT INTO Machines (name, model, status, last_maintenance) VALUES
('Screen Assembler', 'SA-300', 'Running', '2024-05-10'),
('Battery Inserter', 'BI-150', 'Idle', '2024-04-20'),
('Camera Calibrator', 'CC-210', 'Maintenance', '2024-03-30');

-- Employees
INSERT INTO Employees (name, role, shift) VALUES
('John Doe', 'Assembly Operator', 'Morning'),
('Jane Smith', 'Quality Inspector', 'Evening'),
('Mike Brown', 'Machine Technician', 'Night');

-- Work Orders
INSERT INTO WorkOrders (product_id, machine_id, start_date, end_date, status) VALUES
(1, 1, '2024-06-10', '2024-06-12', 'Completed'),
(2, 2, '2024-06-13', '2024-06-14', 'In Progress'),
(3, 3, '2024-06-15', NULL, 'Pending');

-- Machine Usage Logs
INSERT INTO MachineLogs (machine_id, emp_id, work_order_id, usage_start, usage_end) VALUES
(1, 1, 1, '2024-06-10 08:00:00', '2024-06-10 16:00:00'),
(2, 3, 2, '2024-06-13 09:00:00', NULL);

-- QC Reports
INSERT INTO QCReports (work_order_id, inspector_id, inspection_date, passed, defects_found, notes) VALUES
(1, 2, '2024-06-12', 1, 0, 'All units passed inspection.'),
(2, 2, '2024-06-14', 0, 3, 'Minor scratches on display.');

-- Downtime Logs
INSERT INTO DowntimeLogs (machine_id, start_time, end_time, reason) VALUES
(3, '2024-06-15 10:00:00', '2024-06-15 12:00:00', 'Camera calibration maintenance');

-- Costs - Product Costs
INSERT INTO Costs (product_id, cost_type, amount, cost_date, notes) VALUES
(1, 'Product', 250.00, '2024-06-10', 'Production cost for Smartphone X1'),
(2, 'Product', 180.00, '2024-06-13', 'Production cost for Smartphone X1 Mini'),
(3, 'Product', 320.00, '2024-06-15', 'Production cost for Smartphone Pro Max');

-- Costs - Material
INSERT INTO Costs (part_id, cost_type, amount, cost_date, notes) VALUES
(4, 'Material', 60.00, '2024-06-10', 'OLED Display cost'),
(5, 'Material', 30.00, '2024-06-13', 'LCD Display cost'),
(6, 'Material', 20.00, '2024-06-10', 'Battery cost'),
(7, 'Material', 45.00, '2024-06-15', 'Triple Camera Module cost');

-- Costs - Machine
INSERT INTO Costs (machine_id, cost_type, amount, cost_date, notes) VALUES
(1, 'Machine', 8000.00, '2024-05-10', 'Screen Assembler maintenance'),
(2, 'Machine', 5000.00, '2024-04-20', 'Battery Inserter repair');

-- Costs - Employee
INSERT INTO Costs (emp_id, cost_type, amount, cost_date, notes) VALUES
(1, 'Employee', 2500.00, '2024-06-10', 'Salary for John Doe'),
(2, 'Employee', 2700.00, '2024-06-13', 'Salary for Jane Smith');

-- Sample Sell Data
INSERT INTO Sell (product_id, quantity, sell_price, sell_date) VALUES
(1, 10, 499.99, '2024-06-20'),
(2, 5, 399.99, '2024-06-21'),
(3, 2, 699.99, '2024-06-22');

INSERT INTO Sell (part_id, quantity, sell_price, sell_date) VALUES
(4, 20, 80.00, '2024-06-23'),
(6, 15, 35.00, '2024-06-24');
