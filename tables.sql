CREATE TABLE `Customer_info` (
  `cust_id` int NOT NULL AUTO_INCREMENT,
  `cust_name` varchar(32),
  `cust_email` varchar(32)
);

CREATE TABLE `Product_info` (
  `prod_id` int NOT NULL AUTO_INCREMENT,
  `prod_name` varchar(32),
  `domain` varchar(32)
);

CREATE TABLE `Customer_Prod_info` (
  `cust_id` int,
  `prod_id` int,
  `start_date` date,
  `duration_months` int,
  FOREIGN KEY (`cust_id`) REFERENCES `Customer_info`(`cust_id`),
  FOREIGN KEY (`prod_id`) REFERENCES `Product_info`(`prod_id`)
);

CREATE TABLE `product_email_configs` (
  `prod_id` int,
  `days_b4_expiry` int,
  `days_after_activation` int,
  FOREIGN KEY (`prod_id`) REFERENCES `Product_info`(`prod_id`)
);

CREATE TABLE `email_transactions` (
  `customer_id` int,
  `product_name` varchar2(32),
  `domain` varchar2(32),
  `emailDate` date
);
