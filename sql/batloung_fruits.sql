-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: batloung_fruits
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `boxsizes`
--

DROP TABLE IF EXISTS `boxsizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boxsizes` (
  `BoxSizeID` int NOT NULL AUTO_INCREMENT,
  `SizeName` varchar(20) NOT NULL,
  PRIMARY KEY (`BoxSizeID`),
  UNIQUE KEY `SizeName` (`SizeName`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boxsizes`
--

LOCK TABLES `boxsizes` WRITE;
/*!40000 ALTER TABLE `boxsizes` DISABLE KEYS */;
INSERT INTO `boxsizes` VALUES (4,'Extra Large'),(3,'Large'),(2,'Medium'),(1,'Small');
/*!40000 ALTER TABLE `boxsizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fruits`
--

DROP TABLE IF EXISTS `fruits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fruits` (
  `FruitID` int NOT NULL AUTO_INCREMENT,
  `FruitName` varchar(50) NOT NULL,
  `Status` enum('Active','Inactive') DEFAULT 'Active',
  PRIMARY KEY (`FruitID`),
  UNIQUE KEY `FruitName` (`FruitName`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fruits`
--

LOCK TABLES `fruits` WRITE;
/*!40000 ALTER TABLE `fruits` DISABLE KEYS */;
INSERT INTO `fruits` VALUES (1,'Apple','Active'),(2,'Banana','Active'),(3,'Orange','Active'),(4,'Mango','Active'),(5,'Grape','Active'),(10,'Papaya','Active'),(12,'Watermelon','Inactive'),(13,'Naartjie','Active'),(18,'Walnuts','Inactive');
/*!40000 ALTER TABLE `fruits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `OrderItemID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `ProductID` int NOT NULL,
  `Quantity` int NOT NULL,
  `UnitPrice` decimal(10,2) NOT NULL,
  `Subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderItemID`),
  KEY `OrderID` (`OrderID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `VendorID` int NOT NULL,
  `OrderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `TotalAmount` decimal(10,2) DEFAULT '0.00',
  `Status` enum('Pending','Confirmed','Processing','Ready for Collection/Delivery','Completed','Cancelled') DEFAULT 'Pending',
  PRIMARY KEY (`OrderID`),
  KEY `VendorID` (`VendorID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`VendorID`) REFERENCES `streetvendors` (`VendorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `FruitID` int NOT NULL,
  `BoxSizeID` int NOT NULL,
  `SellingPrice` decimal(10,2) NOT NULL,
  `Status` enum('Active','Inactive') DEFAULT 'Active',
  PRIMARY KEY (`ProductID`),
  KEY `FruitID` (`FruitID`),
  KEY `BoxSizeID` (`BoxSizeID`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`FruitID`) REFERENCES `fruits` (`FruitID`),
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`BoxSizeID`) REFERENCES `boxsizes` (`BoxSizeID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (2,1,1,150.00,'Active'),(3,1,2,300.00,'Active'),(4,1,3,550.00,'Active'),(5,2,1,120.00,'Active'),(6,2,2,250.00,'Active'),(7,2,3,450.00,'Active'),(8,3,1,140.00,'Active'),(9,3,2,280.00,'Active'),(10,3,3,500.00,'Active'),(11,4,1,180.00,'Active'),(12,4,2,350.00,'Active'),(13,4,3,650.00,'Active'),(14,5,1,200.00,'Active'),(15,5,2,400.00,'Active'),(16,5,3,750.00,'Active');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchases` (
  `PurchaseID` int NOT NULL AUTO_INCREMENT,
  `SupplierID` int NOT NULL,
  `ProductID` int NOT NULL,
  `Quantity` int NOT NULL,
  `PurchasePrice` decimal(10,2) NOT NULL,
  `PurchaseDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PurchaseID`),
  KEY `SupplierID` (`SupplierID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`),
  CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` VALUES (1,2,11,12,500.00,'2026-10-16 00:41:52'),(2,5,8,1,544.00,'2026-10-16 02:35:59'),(3,6,9,20,1200.00,'2026-10-19 00:00:00'),(4,2,13,11,320.00,'2026-11-02 00:00:00');
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `streetvendors`
--

DROP TABLE IF EXISTS `streetvendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streetvendors` (
  `VendorID` int NOT NULL AUTO_INCREMENT,
  `VendorName` varchar(100) NOT NULL,
  `BusinessName` varchar(150) NOT NULL,
  `Telephone` varchar(30) NOT NULL,
  `Location` varchar(150) NOT NULL,
  `RegistrationDate` date NOT NULL,
  `Status` enum('Active','Inactive') DEFAULT 'Active',
  PRIMARY KEY (`VendorID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streetvendors`
--

LOCK TABLES `streetvendors` WRITE;
/*!40000 ALTER TABLE `streetvendors` DISABLE KEYS */;
INSERT INTO `streetvendors` VALUES (2,'Mpho Ndlovu','Mpho Fresh Fruits','58123456','Maseru Central','2026-10-01','Active'),(3,'Thabo Rantso','Thabo Fruit Market','59123456','Pioneer Road, Maseru','2026-10-02','Active'),(4,'Lerato Mokhethi','Lerato Produce Stall','62123456','Thetsane, Maseru','2026-10-03','Active'),(5,'Kabelo Phafoli','Kabelo Fruit Corner','63123456','Ha Abia, Maseru','2026-10-04','Active'),(6,'Palesa Mofokeng','Palesa Fresh Produce','66123456','Qoaling, Maseru','2026-10-05','Active');
/*!40000 ALTER TABLE `streetvendors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `SupplierID` int NOT NULL AUTO_INCREMENT,
  `SupplierName` varchar(100) NOT NULL,
  `Province` enum('Eastern Cape','Free State','Gauteng','KwaZulu-Natal','Limpopo','Mpumalanga','Northern Cape','North West','Western Cape') NOT NULL,
  `ContactPerson` varchar(100) NOT NULL,
  `Telephone` varchar(30) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PhysicalAddress` varchar(255) NOT NULL,
  PRIMARY KEY (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (2,'Limpopo Fresh Farms','Limpopo','Thabo Mokoena','0712345678','limpopoff@gmail.com','Polokwane, South Africa'),(3,'Western Cape Fruit Supply','Western Cape','Naledi Jacobs','0723456789','westerncapefs@gmail.com','Cape Town, South Africa'),(4,'Free State Fresh Produce','Free State','Kabelo Molefe','0734567890','freestatefp@gmail.com','Bloemfontein, South Africa'),(5,'Mpumalanga Fruit Distributors','Mpumalanga','Lerato Nkosi','0745678901','mpumalangafd@gmail.com','Mbombela, South Africa'),(6,'KwaZulu-Natal Fruit Suppliers','KwaZulu-Natal','Sipho Dlamini','0756789012','kwazulunfs@gmail.com','Durban, South Africa');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-14  1:29:28
