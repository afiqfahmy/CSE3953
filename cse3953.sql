-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2026 at 04:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cse3953`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `items` longtext DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(30) DEFAULT 'PENDING_PAYMENT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `supplier_name`, `items`, `total_amount`, `order_date`, `status`) VALUES
(1, 'Spritzer', 'Mineral Water 1L x 20', 460.00, '2026-06-20 14:51:02', 'PENDING_PAYMENT');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `item_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `item_name`, `quantity`, `unit_price`, `subtotal`) VALUES
(1, 1, 8, 'Mineral Water 1L', 20, 23.00, 460.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `threshold` int(11) NOT NULL DEFAULT 5,
  `expiry_date` date DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'In Stock'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category`, `unit_price`, `quantity`, `threshold`, `expiry_date`, `supplier_name`, `status`) VALUES
(1, 'Dutch Lady Strawberry', 'DRINKS', 1.99, 50, 10, '2026-07-01', 'Nestle', 'In Stock'),
(2, 'Dutch Lady Chocolate', 'DRINKS', 1.99, 50, 10, '2026-06-25', 'Nestle', 'In Stock'),
(3, 'Milo', 'DRINKS', 1.99, 50, 10, '2026-08-01', 'Nestle', 'In Stock'),
(4, 'MAGGI 2 Minutes Kari', 'INSTANT_FOOD', 4.99, 50, 10, '2027-01-01', 'Nestle', 'In Stock'),
(5, 'MAGGI 2 Minutes Tom Yam', 'INSTANT_FOOD', 5.20, 50, 10, '2027-01-01', 'Nestle', 'In Stock'),
(6, 'Classic Flavours Orange', 'DRINKS', 2.60, 30, 10, '2026-06-20', 'F&N', 'In Stock'),
(7, 'Classic Flavours Sarsi', 'DRINKS', 2.60, 50, 10, '2027-01-20', 'F&N', 'In Stock'),
(8, 'Mineral Water 1L', 'DRINKS', 2.30, 100, 20, '2027-12-31', 'Spritzer', 'In Stock'),
(9, 'Snek Ku Tam Tam Crab Flavoured Snacks (500g)', 'SNACKS', 3.50, 50, 10, '2027-12-31', 'Snek Ku', 'In Stock'),
(10, 'Snek Ku Ken Chicken Flavoured Snacks (500g)', 'SNACKS', 3.50, 50, 10, '2027-12-31', 'Snek Ku', 'In Stock'),
(11, 'Gardenia Original Classic', 'DAIRY', 3.40, 30, 10, '2026-06-30', 'Gardenia', 'In Stock'),
(12, 'Dutch Lady Fresh Milk', 'DAIRY', 7.90, 20, 5, '2026-06-25', 'Dutch Lady', 'In Stock'),
(13, 'Ayamas Chicken Nugget', 'FROZEN_FOOD', 12.90, 40, 10, '2027-06-01', 'Ayamas', 'In Stock'),
(14, 'Ramly Chicken Burger Patty', 'FROZEN_FOOD', 15.90, 30, 10, '2027-06-01', 'Ramly', 'In Stock'),
(15, 'Detergent Powder 1kg', 'HOUSEHOLD_ITEMS', 8.50, 25, 5, '2028-01-01', 'TOP', 'In Stock'),
(16, 'Dishwashing Liquid 900ml', 'HOUSEHOLD_ITEMS', 6.90, 30, 5, '2028-01-01', 'Mama Lemon', 'In Stock');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `sale_id` varchar(20) NOT NULL,
  `sale_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `receipt_data` longtext DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `cash_received` decimal(10,2) DEFAULT NULL,
  `change_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`sale_id`, `sale_date`, `total_amount`, `receipt_data`, `payment_method`, `cash_received`, `change_amount`) VALUES
('SALE-000001', '2026-06-20 14:51:02', 12.57, 'Sample Receipt', 'CASH', 20.00, 7.43);

-- --------------------------------------------------------

--
-- Table structure for table `supplier_payments`
--

CREATE TABLE `supplier_payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `bill_code` varchar(100) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` varchar(30) DEFAULT 'PENDING',
  `paid_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `phone`, `password`, `role_id`) VALUES
(1, 'Manager', 'manager@redox.com', '0123456789', '123', 2),
(2, 'Staff', 'staff@redox.com', '0123456788', '123', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `fk_order_items_order` (`order_id`),
  ADD KEY `fk_order_items_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`sale_id`);

--
-- Indexes for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_supplier_payment_order` (`order_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE SET NULL;

--
-- Constraints for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  ADD CONSTRAINT `fk_supplier_payment_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
