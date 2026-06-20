-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2026 at 04:39 PM
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
  `items` text NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(30) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `supplier_name`, `items`, `total_amount`, `order_date`, `status`) VALUES
(10, 'MAGGI', 'MAGGI 2 Minutes x 100 = RM 299.00\nMAGGI Hot Cup Kari x 100 = RM 100.00\n', 399.00, '2026-06-05 21:20:59', 'Completed');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `item_name`, `quantity`, `unit_price`, `subtotal`, `product_id`) VALUES
(17, 10, 'MAGGI 2 Minutes', 100, 2.99, 299.00, 0),
(18, 10, 'MAGGI Hot Cup Kari', 100, 1.00, 100.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `threshold` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiry_date` date DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category`, `unit_price`, `quantity`, `threshold`, `created_at`, `expiry_date`, `supplier_name`) VALUES
(8, 'Kit-Kat', 'SNACKS', 3.90, 33, 10, '2026-05-18 14:45:22', '2027-06-18', 'Megah Holding'),
(9, 'MAGGI 2-Minit Kari', 'INSTANT_FOOD', 5.50, 103, 5, '2026-05-18 14:58:23', '2027-12-18', 'Universiti Malaysia Terengganu');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `sale_id` varchar(50) NOT NULL,
  `sale_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `receipt_data` text NOT NULL,
  `payment_method` varchar(20) DEFAULT 'Cash',
  `cash_received` decimal(10,2) DEFAULT NULL,
  `change_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`sale_id`, `sale_date`, `total_amount`, `receipt_data`, `payment_method`, `cash_received`, `change_amount`) VALUES
('SALE-11138F86', '2026-05-17 12:51:22', 57.20, '[{\"productId\":5,\"productName\":\"Extrajoss\",\"price\":2.6,\"quantity\":22,\"total\":57.2}]', 'Cash', NULL, NULL),
('SALE-157BCA9D', '2026-05-17 12:05:23', 21.10, '[{\"productId\":3,\"productName\":\"Indomie\",\"price\":8,\"quantity\":1,\"total\":8},{\"productId\":2,\"productName\":\"Dutch Lady\",\"price\":4,\"quantity\":1,\"total\":4},{\"productId\":1,\"productName\":\"100 Plus\",\"price\":2.2,\"quantity\":1,\"total\":2.2},{\"productId\":4,\"productName\":\"Kit-Kat\",\"price\":6.9,\"quantity\":1,\"total\":6.9}]', 'Cash', NULL, NULL),
('SALE-25FC21A5', '2026-05-18 04:55:57', 18.20, '[{\"productId\":1,\"productName\":\"100 Plus\",\"price\":2.2,\"quantity\":1,\"total\":2.2},{\"productId\":3,\"productName\":\"Indomie\",\"price\":8,\"quantity\":2,\"total\":16}]', 'Cash', NULL, NULL),
('SALE-29620971', '2026-05-17 12:07:43', 18.90, '[{\"productId\":2,\"productName\":\"Dutch Lady\",\"price\":4,\"quantity\":1,\"total\":4},{\"productId\":3,\"productName\":\"Indomie\",\"price\":8,\"quantity\":1,\"total\":8},{\"productId\":4,\"productName\":\"Kit-Kat\",\"price\":6.9,\"quantity\":1,\"total\":6.9}]', 'Cash', NULL, NULL),
('SALE-2C0A0A08', '2026-05-17 12:50:48', 53.20, '[{\"productId\":1,\"productName\":\"100 Plus\",\"price\":2.2,\"quantity\":23,\"total\":50.6},{\"productId\":5,\"productName\":\"Extrajoss\",\"price\":2.6,\"quantity\":1,\"total\":2.6}]', 'Cash', NULL, NULL),
('SALE-6E0A5733', '2026-05-18 03:10:38', 42.00, '[{\"productId\":6,\"productName\":\"Burger Ramly\",\"price\":7,\"quantity\":6,\"total\":42}]', 'Cash', NULL, NULL),
('SALE-7B92CBBA', '2026-05-18 03:11:22', 45.10, '[{\"productId\":4,\"productName\":\"Kit-Kat\",\"price\":6.9,\"quantity\":1,\"total\":6.9},{\"productId\":3,\"productName\":\"Indomie\",\"price\":8,\"quantity\":1,\"total\":8},{\"productId\":1,\"productName\":\"100 Plus\",\"price\":2.2,\"quantity\":1,\"total\":2.2},{\"productId\":6,\"productName\":\"Burger Ramly\",\"price\":7,\"quantity\":4,\"total\":28}]', 'Cash', NULL, NULL),
('SALE-847EB56C', '2026-05-17 12:12:32', 12.00, '[{\"productId\":3,\"productName\":\"Indomie\",\"price\":8,\"quantity\":1,\"total\":8},{\"productId\":2,\"productName\":\"Dutch Lady\",\"price\":4,\"quantity\":1,\"total\":4}]', 'Cash', NULL, NULL),
('SALE-AE227AF4', '2026-05-18 04:56:23', 17.10, '[{\"productId\":4,\"productName\":\"Kit-Kat\",\"price\":6.9,\"quantity\":1,\"total\":6.9},{\"productId\":3,\"productName\":\"Indomie\",\"price\":8,\"quantity\":1,\"total\":8},{\"productId\":1,\"productName\":\"100 Plus\",\"price\":2.2,\"quantity\":1,\"total\":2.2}]', 'Cash', NULL, NULL),
('SALE-BB5B7BA9', '2026-05-18 04:55:05', 5.50, '[{\"productId\":7,\"productName\":\"Maggi Tomyam\",\"price\":5.5,\"quantity\":1,\"total\":5.5}]', 'Cash', NULL, NULL),
('SALE-C47A217F', '2026-05-17 12:48:51', 10.20, '[{\"productId\":1,\"productName\":\"100 Plus\",\"price\":2.2,\"quantity\":1,\"total\":2.2},{\"productId\":3,\"productName\":\"Indomie\",\"price\":8,\"quantity\":1,\"total\":8}]', 'Cash', NULL, NULL),
('SALE-D970E17C', '2026-05-17 11:54:49', 9.10, '[{\"productId\":1,\"productName\":\"100 Plus\",\"price\":2.2,\"quantity\":1,\"total\":2.2},{\"productId\":4,\"productName\":\"Kit-Kat\",\"price\":6.9,\"quantity\":1,\"total\":6.9}]', 'Cash', NULL, NULL),
('SALE-EC6D486A', '2026-05-17 12:12:48', 14.90, '[{\"productId\":4,\"productName\":\"Kit-Kat\",\"price\":6.9,\"quantity\":1,\"total\":6.9},{\"productId\":3,\"productName\":\"Indomie\",\"price\":8,\"quantity\":1,\"total\":8}]', 'Cash', NULL, NULL),
('SALE-F0CD4A38', '2026-05-17 12:50:08', 4.80, '[{\"productId\":1,\"productName\":\"100 Plus\",\"price\":2.2,\"quantity\":1,\"total\":2.2},{\"productId\":5,\"productName\":\"Extrajoss\",\"price\":2.6,\"quantity\":1,\"total\":2.6}]', 'Cash', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `role_id` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `phone`, `password`, `role_id`, `created_at`) VALUES
(2, 'Admin', 'admin@gmail.com', '0123456789', 'admin123', 2, '2026-05-17 12:39:01'),
(3, 'staff', 'staff@gmail.com', '01987654321', 'staff123', 1, '2026-05-17 12:46:30');

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
  ADD KEY `order_id` (`order_id`);

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
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
