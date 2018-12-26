-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: main_db
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `macd`
--

DROP TABLE IF EXISTS `macd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `macd` (
  `SYMBOL` varchar(20) NOT NULL,
  `INTERVAL` varchar(20) NOT NULL,
  `FASTPERIOD` int(11) NOT NULL,
  `SLOWPERIOD` int(11) NOT NULL,
  `SIGNALPERIOD` int(11) NOT NULL,
  `MACDDATE` date NOT NULL,
  `LASTUPDATEDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`SYMBOL`,`INTERVAL`,`FASTPERIOD`,`SLOWPERIOD`,`SIGNALPERIOD`,`MACDDATE`),
  KEY `MACD_INTERVAL_idx` (`INTERVAL`),
  CONSTRAINT `MACD_INTERVAL` FOREIGN KEY (`INTERVAL`) REFERENCES `interval` (`interval`),
  CONSTRAINT `MACD_SYMBOL` FOREIGN KEY (`SYMBOL`) REFERENCES `stock` (`symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `macd`
--

LOCK TABLES `macd` WRITE;
/*!40000 ALTER TABLE `macd` DISABLE KEYS */;
/*!40000 ALTER TABLE `macd` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-26 14:29:52
