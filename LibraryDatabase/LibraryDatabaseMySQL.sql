-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: library
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `AddressId` int NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Ssn` varchar(11) DEFAULT NULL,
  `InstitutionId` int DEFAULT NULL,
  PRIMARY KEY (`AddressId`),
  KEY `InstitutionId` (`InstitutionId`),
  KEY `address_ibfk_1` (`Ssn`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`Ssn`) REFERENCES `staff` (`Ssn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `address_ibfk_2` FOREIGN KEY (`InstitutionId`) REFERENCES `institution` (`InstitutionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'123 Maple St, Newview','123456789',10012),(2,'456 Oak St, Newview','111223333',10023),(3,'789 Pine St, Newview','444556666',10034),(4,'321 Birch St, Newview','777889999',10041),(5,'654 Elm St, Parkway','101010101',10050),(6,'987 Cedar St, Parkway','949863210',10063),(7,'135 Spruce St, Parkway','234003225',10074),(8,'246 Willow St, Holton','313550099',10085),(9,'357 Poplar St, Holton','555555555',10097),(10,'468 Ash St, Holton','208159345',10108),(11,'579 Fir St, Holton','456881234',10119),(12,'680 Maple St, Holton','777665555',10123),(13,'791 Oak St, Blueside','013579123',10134),(14,'802 Pine St, Octon','392358889',10145),(15,'913 Birch St, Octon','100000001',10154),(16,'024 Elm St, Saan','467044678',10161),(17,'135 Cedar St, Saan','929292929',10176),(18,'246 Spruce St, Saan','222113333',10186),(19,'357 Willow St, Saan','777884494',10197),(20,'468 Ash St, Blueside','100203000',10207);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `ISBN` bigint NOT NULL,
  `Volume` int NOT NULL,
  `Edition` int NOT NULL,
  `Series` int NOT NULL,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (9780123748560,2,21,1),(9780140449136,5,1,2),(9780306406157,4,3,2),(9780471486480,5,1,1),(9780596520687,11,2,2),(9781402894626,1,2,1),(9781598534366,4,3,1),(9781861978769,3,2,1),(9783161484100,2,3,1),(9783540002383,1,1,1);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concerns`
--

DROP TABLE IF EXISTS `concerns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `concerns` (
  `TransactionId` int NOT NULL,
  `StockId` int NOT NULL,
  PRIMARY KEY (`TransactionId`,`StockId`),
  KEY `StockId` (`StockId`),
  CONSTRAINT `concerns_ibfk_1` FOREIGN KEY (`TransactionId`) REFERENCES `transaction` (`TransactionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `concerns_ibfk_2` FOREIGN KEY (`StockId`) REFERENCES `stock` (`StockId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concerns`
--

LOCK TABLES `concerns` WRITE;
/*!40000 ALTER TABLE `concerns` DISABLE KEYS */;
INSERT INTO `concerns` VALUES (837438,1234567),(838328,1234567),(832893,2345678),(812962,3456789),(289161,4567890),(732783,5678901),(882338,6789012),(892392,7890123),(892934,8901234),(383483,9012345);
/*!40000 ALTER TABLE `concerns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contributes`
--

DROP TABLE IF EXISTS `contributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contributes` (
  `ContributorId` int NOT NULL,
  `StockId` int NOT NULL,
  `Position` varchar(90) NOT NULL DEFAULT 'MISC',
  PRIMARY KEY (`ContributorId`,`StockId`),
  KEY `StockId` (`StockId`),
  CONSTRAINT `contributes_ibfk_1` FOREIGN KEY (`ContributorId`) REFERENCES `contributor` (`ContributorId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contributes_ibfk_2` FOREIGN KEY (`StockId`) REFERENCES `stock` (`StockId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contributes`
--

LOCK TABLES `contributes` WRITE;
/*!40000 ALTER TABLE `contributes` DISABLE KEYS */;
INSERT INTO `contributes` VALUES (154279,500123,'Librarian'),(202314,500128,'Library Technician'),(340463,500137,'Systems Administrator'),(444823,500141,'Media Specialist'),(491890,500135,'Events Coordinator'),(506702,500134,'Library Assistant'),(530723,500140,'Library Director'),(531420,500126,'Collection Manager'),(550777,500142,'Preservation Specialist'),(564643,500136,'Acquisitions Librarian'),(639874,500127,'Archivist'),(648392,500129,'Information Specialist'),(660877,500139,'Young Adult Librarian'),(671582,500133,'Research Librarian'),(738249,500124,'Cataloging Specialist'),(761030,500130,'Circulation Supervisor'),(780932,500132,'Children\'s Librarian'),(829376,500131,'Digital Resources Lead'),(890181,500138,'Outreach Coordinator'),(904612,500125,'Reference Librarian');
/*!40000 ALTER TABLE `contributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contributor`
--

DROP TABLE IF EXISTS `contributor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contributor` (
  `ContributorId` int NOT NULL,
  `PersonId` int DEFAULT NULL,
  `InstitutionId` int DEFAULT NULL,
  PRIMARY KEY (`ContributorId`),
  KEY `PersonId` (`PersonId`),
  KEY `InstitutionId` (`InstitutionId`),
  CONSTRAINT `contributor_ibfk_1` FOREIGN KEY (`PersonId`) REFERENCES `person` (`PersonId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contributor_ibfk_2` FOREIGN KEY (`InstitutionId`) REFERENCES `institution` (`InstitutionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contributor`
--

LOCK TABLES `contributor` WRITE;
/*!40000 ALTER TABLE `contributor` DISABLE KEYS */;
INSERT INTO `contributor` VALUES (154279,80101,10012),(202314,80106,10063),(340463,80115,10154),(444823,80119,10197),(491890,80113,10134),(506702,80112,10123),(530723,80118,10186),(531420,80104,10041),(550777,80120,10207),(564643,80114,10145),(639874,80105,10050),(648392,80107,10074),(660877,80117,10176),(671582,80111,10119),(738249,80102,10023),(761030,80108,10085),(780932,80110,10108),(829376,80109,10097),(890181,80116,10161),(904612,80103,10034);
/*!40000 ALTER TABLE `contributor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edits`
--

DROP TABLE IF EXISTS `edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edits` (
  `ContributorId` int NOT NULL,
  `PublicationId` int NOT NULL,
  PRIMARY KEY (`ContributorId`,`PublicationId`),
  KEY `PublicationId` (`PublicationId`),
  CONSTRAINT `edits_ibfk_1` FOREIGN KEY (`ContributorId`) REFERENCES `contributor` (`ContributorId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `edits_ibfk_2` FOREIGN KEY (`PublicationId`) REFERENCES `publication` (`PublicationId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edits`
--

LOCK TABLES `edits` WRITE;
/*!40000 ALTER TABLE `edits` DISABLE KEYS */;
INSERT INTO `edits` VALUES (154279,121283),(202314,209164),(340463,343463),(444823,444423),(491890,490890),(506702,505702),(531420,534021),(530723,537723),(550777,555777),(564643,565643),(639874,637683),(648392,647193),(660877,668877),(671582,670282),(738249,723822),(761030,760023),(780932,780733),(829376,823893),(890181,893181),(904612,905143);
/*!40000 ALTER TABLE `edits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epublication`
--

DROP TABLE IF EXISTS `epublication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epublication` (
  `PublicationId` int NOT NULL,
  PRIMARY KEY (`PublicationId`),
  CONSTRAINT `epublication_ibfk_1` FOREIGN KEY (`PublicationId`) REFERENCES `publication` (`PublicationId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epublication`
--

LOCK TABLES `epublication` WRITE;
/*!40000 ALTER TABLE `epublication` DISABLE KEYS */;
INSERT INTO `epublication` VALUES (121283),(209164),(343463),(444423),(490890),(505702),(534021),(537723),(555777),(565643),(637683),(647193),(668877),(670282),(723822),(760023),(780733),(823893),(893181),(905143);
/*!40000 ALTER TABLE `epublication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fine`
--

DROP TABLE IF EXISTS `fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fine` (
  `TransactionId` int NOT NULL,
  `Motive` varchar(50) NOT NULL,
  `Issued` date DEFAULT NULL,
  `Cost` float NOT NULL,
  PRIMARY KEY (`TransactionId`,`Motive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fine`
--

LOCK TABLES `fine` WRITE;
/*!40000 ALTER TABLE `fine` DISABLE KEYS */;
INSERT INTO `fine` VALUES (289161,'Overdue Item','2020-03-07',0),(383483,'Lost Item','2015-04-04',48.98),(732783,'Damaged Item','2019-10-02',28.56),(812962,'Lost Item','2021-12-15',27.45),(832893,'Damaged Item','2021-12-11',10),(837438,'Lost Item','2022-01-12',33.79),(838328,'Overdue Item','2023-05-09',0),(882338,'Overdue Item','2018-06-14',0),(892392,'Damaged Item','2021-12-21',23.25),(892934,'Overdue Item','2022-02-18',0);
/*!40000 ALTER TABLE `fine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `GenreId` int NOT NULL,
  `Genre` varchar(30) NOT NULL,
  `PublicationId` int DEFAULT NULL,
  `MediaId` int DEFAULT NULL,
  `PublishedId` int DEFAULT NULL,
  PRIMARY KEY (`GenreId`),
  KEY `PublicationId` (`PublicationId`),
  KEY `MediaId` (`MediaId`),
  KEY `PublishedId` (`PublishedId`),
  CONSTRAINT `genre_ibfk_1` FOREIGN KEY (`PublicationId`) REFERENCES `publication` (`PublicationId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `genre_ibfk_2` FOREIGN KEY (`MediaId`) REFERENCES `media` (`MediaId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `genre_ibfk_3` FOREIGN KEY (`PublishedId`) REFERENCES `published` (`PublishedId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (101100,'Science',301010,403020,505030),(102200,'Mystery',NULL,404030,506040),(103300,'Family',302020,NULL,507050),(104400,'Science',NULL,405040,508060),(105500,'History',303030,406050,NULL),(106600,'Mystery',304040,NULL,509070),(107700,'Biography',NULL,407060,510080),(108800,'Romance',305050,NULL,NULL),(109900,'Science Fiction',NULL,408070,511090),(110000,'Fantasy',306060,409080,NULL),(111100,'Thriller',NULL,NULL,512100),(112200,'Science',307070,410090,NULL),(113300,'Adventure',NULL,411100,513110),(114400,'Science',308080,NULL,NULL),(115500,'Drama',NULL,412110,514120),(116600,'Science Fiction',309090,NULL,NULL),(117700,'Science Fiction',310100,413120,NULL),(118800,'History',NULL,414130,515130),(119900,'Poetry',311110,NULL,NULL),(120000,'Science Fiction',NULL,415140,516140);
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institution`
--

DROP TABLE IF EXISTS `institution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institution` (
  `InstitutionId` int NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Type` varchar(15) NOT NULL,
  PRIMARY KEY (`InstitutionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institution`
--

LOCK TABLES `institution` WRITE;
/*!40000 ALTER TABLE `institution` DISABLE KEYS */;
INSERT INTO `institution` VALUES (101,'St. Marys','Private'),(122,'Rocky River','Public'),(123,'Clyde','Public'),(222,'Twilight Citadel','Private'),(246,'Enchanted Quill','Public'),(414,'Everlore Archives','Private'),(555,'Whispering Pages','Public'),(678,'Sapphire Seraphim','Public'),(919,'Robinson','Public'),(999,'Oracle Oasis','Public');
/*!40000 ALTER TABLE `institution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal`
--

DROP TABLE IF EXISTS `journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journal` (
  `ISSN` varchar(9) NOT NULL,
  `Issue` int NOT NULL,
  `Volume` int NOT NULL,
  `Series` int NOT NULL,
  PRIMARY KEY (`ISSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal`
--

LOCK TABLES `journal` WRITE;
/*!40000 ALTER TABLE `journal` DISABLE KEYS */;
INSERT INTO `journal` VALUES ('0282-8282',1,3,2),('1217-8637',8,12,4),('1513-6548',23,5,2),('2373-0098',6,2,4),('2928-8383',4,9,3),('3638-3733',2,7,2),('4948-4767',4,2,4),('5332-0009',9,5,1),('6765-8443',12,7,3),('7024-8093',3,4,2),('7093-9364',10,8,7),('7236-8373',2,3,1),('7373-8787',7,1,1),('7771-9922',16,4,3),('7987-0023',15,5,1),('8211-0112',8,8,8),('8221-0883',9,2,2),('8348-8312',11,5,5),('8928-9222',5,4,3),('9232-1114',3,3,3);
/*!40000 ALTER TABLE `journal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `librarymember`
--

DROP TABLE IF EXISTS `librarymember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `librarymember` (
  `MemberId` bigint NOT NULL,
  `PersonId` int NOT NULL,
  `MemberStatus` varchar(10) NOT NULL DEFAULT 'INACTIVE',
  `JoinDate` date NOT NULL,
  `ExpirationDate` date NOT NULL,
  PRIMARY KEY (`MemberId`),
  KEY `librarymember_ibfk_1` (`PersonId`),
  CONSTRAINT `librarymember_ibfk_1` FOREIGN KEY (`PersonId`) REFERENCES `person` (`PersonId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `librarymember`
--

LOCK TABLES `librarymember` WRITE;
/*!40000 ALTER TABLE `librarymember` DISABLE KEYS */;
INSERT INTO `librarymember` VALUES (9126821684801,98712,'INACTIVE','2018-03-13','2021-03-13'),(9127238648923,30913,'INACTIVE','2020-09-08','2023-09-08'),(23785782152363,11223,'ACTIVE','2021-07-24','2024-07-24'),(52762523652371,67584,'ACTIVE','2022-05-09','2025-05-09'),(66448373731238,73789,'ACTIVE','2022-05-01','2025-05-01'),(71281256129356,20402,'ACTIVE','2023-06-17','2026-06-17'),(72316513783412,12345,'ACTIVE','2021-01-12','2024-01-12'),(72521781251235,47472,'INACTIVE','2020-11-10','2023-11-10'),(76123512351235,30643,'ACTIVE','2022-08-03','2025-08-03'),(82191008383976,23782,'ACTIVE','2023-08-21','2026-08-21'),(82372617123571,81282,'ACTIVE','2023-05-02','2026-05-02'),(82638926286383,41451,'ACTIVE','2022-07-17','2025-07-17'),(89126376376365,83332,'INACTIVE','2020-10-24','2023-10-24'),(89126891278534,77773,'ACTIVE','2021-03-17','2024-03-17'),(89216812821358,47556,'ACTIVE','2023-06-12','2026-06-12'),(89268286268361,55553,'ACTIVE','2021-04-01','2024-04-01'),(90272862682682,23451,'ACTIVE','2023-05-14','2026-05-14'),(91268127812363,18283,'INACTIVE','2010-01-07','2013-01-07'),(92872626376223,34726,'ACTIVE','2022-01-23','2025-01-23'),(96382621861268,32423,'INACTIVE','2015-02-10','2018-02-10');
/*!40000 ALTER TABLE `librarymember` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `RoomNumber` int NOT NULL,
  `Name` varchar(15) NOT NULL,
  `Type` varchar(15) NOT NULL DEFAULT 'GENERAL',
  PRIMARY KEY (`RoomNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (101,'Reading Room','Children'),(108,'Computer Lab','Children'),(113,'Media','Children'),(200,'Main','General'),(201,'Reading Room','Teens'),(207,'Media','Teens'),(220,'Event Room 1','General'),(222,'Event Room 2','General'),(224,'Event Room 3','General'),(226,'Event Room 4','General'),(230,'Study Room','General'),(300,'Reference Room','General'),(301,'Reading Room','Adults'),(305,'Computer Lab','General'),(315,'Media','Adults'),(320,'Meeting Room 1','General'),(322,'Meeting Room 2','General'),(324,'Meeting Room 3','General'),(326,'Meeting Room 4','General'),(328,'Periodical Room','General');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `magazine`
--

DROP TABLE IF EXISTS `magazine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `magazine` (
  `ISSN` varchar(9) NOT NULL,
  `Issue` int NOT NULL,
  `Volume` int NOT NULL,
  PRIMARY KEY (`ISSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `magazine`
--

LOCK TABLES `magazine` WRITE;
/*!40000 ALTER TABLE `magazine` DISABLE KEYS */;
INSERT INTO `magazine` VALUES ('0193-0196',2,6),('1010-1010',8,4),('1045-5235',1,1),('1212-0101',8,8),('1234-5678',4,10),('1315-1293',5,13),('1783-7094',4,4),('1928-3746',11,9),('2040-6080',2,12),('2309-7432',10,12),('3487-3448',9,4),('3670-9678',7,3),('4047-3331',7,2),('4455-7766',2,3),('6413-0034',5,3),('8181-1818',6,15),('8232-4547',3,5),('9060-5656',3,7),('9876-5432',3,9),('9909-4771',1,4);
/*!40000 ALTER TABLE `magazine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `MediaId` int NOT NULL,
  `Title` varchar(30) NOT NULL,
  `Type` varchar(15) NOT NULL,
  `Rating` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`MediaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (100200,'Kill Shot','Movie','R'),(102030,'Home Alone','Movie','PG'),(123456,'Shrek','Movie','PG'),(234561,'Plane','Movie','R'),(303123,'Rush Hour','Movie','PG-13'),(345127,'Wall-E','Movie','G'),(445566,'Ratatouille','Movie','G'),(511511,'Spongebob Squarepants Season 1','Tv Show','G'),(623623,'Toy Story','Movie','G'),(678058,'Spongebob Squarepants Season 2','Tv Show','G'),(767676,'Spongebob Squarepants Season 3','Tv Show','G'),(777000,'Grown Ups','Movie','PG-13'),(848484,'Missing','Movie','PG-13'),(898989,'Monsters Inc','Movie','G'),(901902,'We’re the Millers','Movie','R'),(912834,'Grey’s Anatomy Season 1','Tv Show','PG-13'),(987654,'Toy Story 2','Movie','G');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newspaper`
--

DROP TABLE IF EXISTS `newspaper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newspaper` (
  `ISSN` varchar(9) NOT NULL,
  `Edition` int NOT NULL,
  `Section` int NOT NULL,
  PRIMARY KEY (`ISSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newspaper`
--

LOCK TABLES `newspaper` WRITE;
/*!40000 ALTER TABLE `newspaper` DISABLE KEYS */;
INSERT INTO `newspaper` VALUES ('0102-8467',10,5),('0293-1428',21,1),('1212-1210',8,4),('2020-2082',9,2),('2365-8373',3,2),('3028-7656',10,3),('3131-4040',12,4),('3844-9282',15,2),('5555-5556',10,4),('6565-7676',7,5),('6590-9302',3,1),('7463-3838',5,1),('7483-0137',8,7),('8081-8382',6,1),('8223-1112',4,4),('8272-8338',9,3),('8273-8373',11,4),('8287-2898',2,3),('9192-3737',22,6),('9989-0013',5,2);
/*!40000 ALTER TABLE `newspaper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `PersonId` int NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `MiddleInitial` varchar(1) DEFAULT NULL,
  `LastName` varchar(20) NOT NULL,
  PRIMARY KEY (`PersonId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (11223,'Ali','J','Bazzi'),(12345,'John','A','Hunter'),(18283,'Leonard','E','Raptor'),(20402,'Dunya','L','Alamari'),(23451,'Ben','Q','Lanzon'),(23782,'Meredith','W','Russler'),(30643,'Tonya','G','Duncan'),(30913,'Jackson','P','Waters'),(32423,'Mariam','Y','Faraj'),(34726,'Peter','P','Parker'),(41451,'Diana','G','Morue'),(47472,'Ally','N','Garrett'),(47556,'Julie','H','Winkler'),(55553,'Ross','F','Gellar'),(67584,'Tom','T','Tucker'),(73789,'Penny','W','Curie'),(77773,'Sheldon','J','Cooper'),(81282,'Alex','H','Benson'),(83332,'Jeremy','K','Webber'),(98712,'Patrick','T','Robbins');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone` (
  `PhoneId` int NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Ssn` varchar(11) DEFAULT NULL,
  `InstitutionId` int DEFAULT NULL,
  PRIMARY KEY (`PhoneId`),
  KEY `Ssn` (`Ssn`),
  KEY `InstitutionId` (`InstitutionId`),
  CONSTRAINT `phone_ibfk_1` FOREIGN KEY (`Ssn`) REFERENCES `staff` (`Ssn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `phone_ibfk_2` FOREIGN KEY (`InstitutionId`) REFERENCES `institution` (`InstitutionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

LOCK TABLES `phone` WRITE;
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
INSERT INTO `phone` VALUES (1,'4563873837','208159345',10108),(293,'0927837838','234003225',10074),(1001,'2311238932','555555555',10097),(1030,'5628337338','929292929',10176),(1212,'2481231234','777889999',10041),(1234,'3135555555','123456789',10012),(2324,'2138334793','013579123',10134),(3311,'4563737838','392358889',10145),(4747,'7838328947','777665555',10123),(5566,'5683837893','777884494',10197),(5678,'1234567890','111223333',10023),(6335,'8937837834','313550099',10085),(7195,'5868387458','456881234',10119),(7373,'8884345678','101010101',10050),(7727,'6748282839','467044678',10161),(7824,'1238948483','100000001',10154),(8989,'3138887378','222113333',10186),(9012,'3130000000','444556666',10034),(9129,'7179289197','100203000',10207),(9567,'9033093393','949863210',10063);
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presides`
--

DROP TABLE IF EXISTS `presides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `presides` (
  `TransactionId` int NOT NULL,
  `Ssn` varchar(11) NOT NULL,
  `MemberId` bigint NOT NULL,
  PRIMARY KEY (`TransactionId`,`Ssn`,`MemberId`),
  KEY `Ssn` (`Ssn`),
  KEY `MemberId` (`MemberId`),
  CONSTRAINT `presides_ibfk_1` FOREIGN KEY (`TransactionId`) REFERENCES `transaction` (`TransactionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `presides_ibfk_2` FOREIGN KEY (`Ssn`) REFERENCES `staff` (`Ssn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `presides_ibfk_3` FOREIGN KEY (`MemberId`) REFERENCES `librarymember` (`MemberId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presides`
--

LOCK TABLES `presides` WRITE;
/*!40000 ALTER TABLE `presides` DISABLE KEYS */;
INSERT INTO `presides` VALUES (892934,'313550099',9126821684801),(892392,'234003225',9127238648923),(732783,'101010101',23785782152363),(882338,'949863210',71281256129356),(383483,'555555555',72316513783412),(838328,'123456789',72316513783412),(812962,'444556666',72521781251235),(289161,'777889999',76123512351235),(832893,'111223333',82372617123571),(736347,'777665555',89268286268361),(837438,'208159345',90272862682682),(983476,'456881234',96382621861268);
/*!40000 ALTER TABLE `presides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication`
--

DROP TABLE IF EXISTS `publication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication` (
  `PublicationId` int NOT NULL,
  `Title` varchar(50) NOT NULL,
  PRIMARY KEY (`PublicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication`
--

LOCK TABLES `publication` WRITE;
/*!40000 ALTER TABLE `publication` DISABLE KEYS */;
INSERT INTO `publication` VALUES (121283,'Gone with the Wind'),(209164,'Animal Farm'),(343463,'To Kill a Mockingbird'),(444423,'The Hobbit'),(490890,'The MLA Style Manual'),(505702,'Charlotte’s Web'),(534021,'Fundamentals of Physics'),(537723,'The Crucible'),(555777,'Chess for Dummies'),(565643,'Rich Dad Poor Dad'),(637683,'The Outsiders'),(647193,'Odyssey'),(668877,'Romeo and Juliet'),(670282,'The Cat in the Hat'),(723822,'Lord of the Rings'),(760023,'Moby Dick'),(780733,'Algorithms in a Nutshell'),(823893,'Fundamentals of Database Systems'),(893181,'Percy Jackson and the Lightning Thief'),(905143,'Cooking for Dummies');
/*!40000 ALTER TABLE `publication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `published`
--

DROP TABLE IF EXISTS `published`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `published` (
  `PublishedId` int NOT NULL,
  `Pages` int DEFAULT NULL,
  `Language` varchar(15) DEFAULT NULL,
  `Date` date NOT NULL,
  `PublicationId` int NOT NULL,
  `ISSN` int DEFAULT NULL,
  `ISBN` bigint DEFAULT NULL,
  PRIMARY KEY (`PublishedId`),
  KEY `PublicationId` (`PublicationId`),
  KEY `ISSN` (`ISSN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `published_ibfk_1` FOREIGN KEY (`PublicationId`) REFERENCES `publication` (`PublicationId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `published`
--

LOCK TABLES `published` WRITE;
/*!40000 ALTER TABLE `published` DISABLE KEYS */;
INSERT INTO `published` VALUES (1234567,410,'Arabic','2023-09-10',823893,90123456,9781598534366),(2345678,300,'English','2023-01-15',121283,12345678,9783161484100),(2345679,360,'Arabic','2023-10-05',444423,1234567,9780140449136),(3456789,220,'Spanish','2023-02-10',723822,23456789,9781402894626),(4567890,150,'French','2023-03-05',905143,34567890,9780596520687),(5678901,500,'German','2023-04-20',534021,45678901,9780306406157),(6789012,350,'Italian','2023-05-15',637683,56789012,9783540002383),(7890123,280,'English','2023-06-30',209164,67890123,9780123748560),(8901234,450,'Spanish','2023-07-22',647193,78901234,9780471486480),(9012345,320,'Spanish','2023-08-18',760023,89012345,9781861978769);
/*!40000 ALTER TABLE `published` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserves`
--

DROP TABLE IF EXISTS `reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserves` (
  `Reservee` bigint NOT NULL,
  `RoomNumber` int NOT NULL,
  `Title` varchar(255) NOT NULL DEFAULT 'RESERVATION',
  `Purpose` varchar(255) NOT NULL DEFAULT 'MISC',
  `Start` date NOT NULL,
  `End` date NOT NULL,
  PRIMARY KEY (`Reservee`,`RoomNumber`),
  KEY `RoomNumber` (`RoomNumber`),
  CONSTRAINT `reserves_ibfk_1` FOREIGN KEY (`Reservee`) REFERENCES `librarymember` (`MemberId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_ibfk_2` FOREIGN KEY (`RoomNumber`) REFERENCES `location` (`RoomNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserves`
--

LOCK TABLES `reserves` WRITE;
/*!40000 ALTER TABLE `reserves` DISABLE KEYS */;
INSERT INTO `reserves` VALUES (23785782152363,226,'Construction Club','Build and play with Lego, Keva, Duplo and more','2023-11-28','2023-11-28'),(23785782152363,326,'Group Project Meeting','Classmates working on a project','2023-11-05','2023-11-05'),(52762523652371,228,'Toys for Tots','Please donate in this room full of boxes to the unfortunates!','2023-12-01','2023-12-23'),(66448373731238,320,'Group Project Meeting','Classmates working on a project','2023-10-30','2023-10-31'),(71281256129356,220,'Teens Arts & Crafts','Create sorts of creative things','2023-11-11','2023-11-11'),(72316513783412,220,'Anti-Bullying','Stop people from bullying other people','2023-11-12','2023-11-14'),(72316513783412,322,'Business Meeting','Coworkers getting together in a meeting','2023-11-27','2023-11-27'),(76123512351235,224,'Children’s Arts & Crafts','Create sorts of creative things','2023-11-04','2023-11-04'),(76123512351235,328,'Business Meeting','Coworkers getting together in a meeting','2023-10-14','2023-10-14'),(82191008383976,224,'What Thanksgiving is All About','Lecture about the history and philosophy of Thanksgiving','2023-11-21','2023-11-21'),(82191008383976,322,'Group Project Meeting','Classmates working on a project','2023-11-14','2023-11-14'),(82372617123571,322,'Business Meeting','Coworkers getting together in a meeting','2023-10-13','2023-10-13'),(82638926286383,228,'Marvel Superhero Discussion for Teens','To conversate over our favorite superheros','2023-10-30','2023-10-30'),(89126376376365,320,'Book Club','People getting together to discuss on a book they have been reading about','2023-12-05','2023-12-05'),(89126891278534,228,'Children’s Halloween Party','Partying with candy, games, and books!','2023-10-31','2023-10-31'),(89216812821358,324,'Group Project Meeting','Classmates working on a project','2023-11-13','2023-11-13'),(89268286268361,220,'Story Time: The Cat in the Hat','Let’s sit and read this great Dr Seuss book!','2023-11-28','2023-11-28'),(90272862682682,320,'Group Project Meeting','Classmates working on a project','2023-11-06','2023-11-06'),(90272862682682,326,'Group Project Meeting','Classmates working on a project','2023-11-05','2023-11-05'),(92872626376223,328,'Group Project Meeting','Classmates working on a project','2023-11-12','2023-11-12');
/*!40000 ALTER TABLE `reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serial`
--

DROP TABLE IF EXISTS `serial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serial` (
  `ISSN` int NOT NULL,
  PRIMARY KEY (`ISSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serial`
--

LOCK TABLES `serial` WRITE;
/*!40000 ALTER TABLE `serial` DISABLE KEYS */;
INSERT INTO `serial` VALUES (2002822),(10139812),(10708089),(12120035),(13578300),(17348734),(30469383),(47568899),(56569898),(64789813),(71238745),(73738239),(76198389),(77278229),(81289292),(82897827),(89238282),(89328422),(89380120),(90908727);
/*!40000 ALTER TABLE `serial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shelf`
--

DROP TABLE IF EXISTS `shelf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shelf` (
  `RoomNumber` int NOT NULL,
  `Category` varchar(20) NOT NULL DEFAULT 'MISC',
  PRIMARY KEY (`RoomNumber`),
  CONSTRAINT `shelf_ibfk_1` FOREIGN KEY (`RoomNumber`) REFERENCES `location` (`RoomNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shelf`
--

LOCK TABLES `shelf` WRITE;
/*!40000 ALTER TABLE `shelf` DISABLE KEYS */;
INSERT INTO `shelf` VALUES (101,'Books'),(108,'CDs'),(110,'DVDs'),(112,'Audio Books'),(113,'CDs'),(116,'Books'),(119,'E-Books'),(200,'Books'),(201,'Books'),(204,'Journals'),(207,'CDs'),(209,'DVDs'),(301,'Books'),(305,'Newpapers'),(315,'DVDs'),(317,'CDs'),(322,'Journals'),(324,'Serial'),(328,'Magazines'),(329,'Newspapers');
/*!40000 ALTER TABLE `shelf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `space`
--

DROP TABLE IF EXISTS `space`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `space` (
  `RoomNumber` int NOT NULL,
  `Capacity` int NOT NULL DEFAULT '5',
  PRIMARY KEY (`RoomNumber`),
  CONSTRAINT `space_ibfk_1` FOREIGN KEY (`RoomNumber`) REFERENCES `location` (`RoomNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `space`
--

LOCK TABLES `space` WRITE;
/*!40000 ALTER TABLE `space` DISABLE KEYS */;
INSERT INTO `space` VALUES (101,256),(108,120),(113,145),(200,500),(201,235),(207,150),(220,96),(222,96),(224,96),(226,96),(230,372),(300,58),(301,231),(305,250),(315,153),(320,35),(322,35),(324,35),(326,35),(328,107);
/*!40000 ALTER TABLE `space` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `Ssn` varchar(9) NOT NULL,
  `Role` varchar(45) NOT NULL DEFAULT 'None',
  `Salary` float NOT NULL,
  `Birthday` date NOT NULL,
  `Age` int NOT NULL,
  `Sex` varchar(1) NOT NULL,
  `Supervisor` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`Ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('013579123','Reference Librarian',56074.6,'1974-08-11',49,'M','555555555'),('100000001','Technology Specialist',45076.3,'1980-04-15',43,'M','456881234'),('100203000','Security Guard',32046.9,'1973-10-27',50,'F','456881234'),('101010101','Security Guard',28234.5,'1983-05-27',40,'M','456881234'),('111223333','Library Assistant',25000,'2000-03-18',23,'F','555555555'),('123456789','Librarian',52000,'1967-09-01',56,'F','555555555'),('222113333','Children’s Librarian',40459.9,'1986-09-03',37,'F','555555555'),('234003225','Reference Librarian',54219.3,'1957-01-13',66,'F','555555555'),('313550099','Children’s Librarian',43273.5,'1991-08-16',32,'F','555555555'),('392358889','Teen Librarian',49081.2,'1987-07-18',36,'M','555555555'),('444556666','Teen Librarian',48000,'1995-07-06',28,'F','555555555'),('456801234','Library Director',110408,'1953-03-17',70,'F',NULL),('456881234','Librarian',53213.1,'1960-05-14',63,'F','555555555'),('467044678','Teen Librarian',47568,'1989-10-13',34,'F','555555555'),('555555555','Facility Manager',108866,'1970-11-24',53,'M','456881234'),('777665555','Library Assistant',23031.9,'1998-02-14',25,'M','555555555'),('777884494','Library Assistant',17083.7,'2006-11-09',17,'F','555555555'),('777889999','Children’s Librarian',45554.7,'1982-04-05',41,'F','555555555'),('929292929','Reference Librarian',54018.4,'1971-06-02',52,'M','555555555'),('949863210','Library Assistant',19600.1,'2005-06-19',18,'M','555555555');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `StockId` int NOT NULL,
  `ItemCondition` varchar(255) NOT NULL,
  `RoomNumber` int DEFAULT NULL,
  `PublishedId` int DEFAULT NULL,
  `MediaId` int DEFAULT NULL,
  PRIMARY KEY (`StockId`),
  KEY `PublishedId` (`PublishedId`),
  KEY `MediaId` (`MediaId`),
  KEY `RoomNumber` (`RoomNumber`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`PublishedId`) REFERENCES `published` (`PublicationId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`MediaId`) REFERENCES `media` (`MediaId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stock_ibfk_3` FOREIGN KEY (`RoomNumber`) REFERENCES `shelf` (`RoomNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1234567,'New',101,2345678,3456789),(1234568,'Excellent',110,2345678,3456789),(2345678,'Good',102,3456789,4567890),(3456789,'Fair',103,4567890,5678901),(4567890,'Excellent',104,5678901,6789012),(5678901,'Worn',105,6789012,7890123),(6789012,'Damaged',106,7890123,8901234),(7890121,'New',107,8901234,9012345),(8901234,'Good',108,9012345,1234567),(9012345,'Fair',109,1234567,2345678);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `SupplierId` int NOT NULL,
  `Type` varchar(90) NOT NULL,
  `InstitutionId` int DEFAULT NULL,
  `PersonId` int DEFAULT NULL,
  PRIMARY KEY (`SupplierId`),
  KEY `InstitutionId` (`InstitutionId`),
  KEY `PersonId` (`PersonId`),
  CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`InstitutionId`) REFERENCES `institution` (`InstitutionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `supplier_ibfk_2` FOREIGN KEY (`PersonId`) REFERENCES `person` (`PersonId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (10101,'Book Supplier',10012,5001),(10102,'Journal Subscription',10023,5002),(10103,'Digital Resources',10034,5003),(10104,'Furniture',10041,5004),(10105,'Computer Hardware',10050,5005),(10106,'IT Services',10063,5006),(10107,'Archival Supplies',10074,5007),(10108,'Office Supplies',10085,5008),(10109,'E-books',10097,5009),(10110,'Periodicals',10108,5010),(10111,'Audio-Visual Equipment',10119,5011),(10112,'Maintenance Services',10123,5012),(10113,'Security Systems',10134,5013),(10114,'Consulting Services',10145,5014),(10115,'Library Software',10154,5015),(10116,'Printing Services',10161,5016),(10117,'Educational Materials',10176,5017),(10118,'Special Collections',10186,5018),(10119,'Event Planning Services',10197,5019),(10120,'Restoration Services',10207,5020);
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `TicketId` int NOT NULL,
  `Issue` varchar(100) NOT NULL,
  `Start` date NOT NULL,
  `Due` date NOT NULL,
  `Completed` date DEFAULT NULL,
  `MemberStatus` varchar(15) NOT NULL DEFAULT 'INCOMPLETE',
  `Assignee` varchar(9) NOT NULL,
  PRIMARY KEY (`TicketId`),
  KEY `Assignee` (`Assignee`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`Assignee`) REFERENCES `staff` (`Ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1001,'Book Cataloging Error','2023-11-01','2023-11-10','2023-11-09','Closed','777665555'),(1002,'Library Network Outage','2023-11-02','2023-11-12','2023-11-11','Closed','100000001'),(1003,'RFID System Malfunction','2023-11-03','2023-11-13',NULL,'Open','100000001'),(1004,'Staff Training on New System','2023-11-04','2023-11-14',NULL,'Open','100000001'),(1005,'Public Computer Upgrade','2023-11-05','2023-11-15',NULL,'In Progress','777665555'),(1006,'eBook Licensing Issue','2023-11-06','2023-11-16',NULL,'In Progress','777665555'),(1007,'Archive Room Humidity Control','2023-11-07','2023-11-17','2023-11-16','Closed','100000001'),(1008,'Online Catalogue Downtime','2023-11-08','2023-11-18','2023-11-17','Closed','777665555'),(1009,'Wi-Fi Access Interruption','2023-11-09','2023-11-19',NULL,'Open','100000001'),(1010,'Overdue Notices Automation','2023-11-10','2023-11-20',NULL,'In Progress','100000001'),(1011,'Printer Network Connection','2023-11-11','2023-11-21',NULL,'Open','777665555'),(1012,'Interlibrary Loan System Bug','2023-11-12','2023-11-22','2023-11-21','Closed','777665555'),(1013,'Audio-Visual Equipment Issue','2023-11-13','2023-11-23',NULL,'In Progress','100000001'),(1014,'Self-Checkout Machine Error','2023-11-14','2023-11-24',NULL,'Open','100000001'),(1015,'Damaged Books Reporting','2023-11-15','2023-11-25',NULL,'In Progress','100000001'),(1016,'Security System Upgrade','2023-11-16','2023-11-26',NULL,'Open','100000001'),(1017,'Shelving Unit Replacement','2023-11-17','2023-11-27',NULL,'In Progress','100000001'),(1018,'Children\'s Section Renovation','2023-11-18','2023-11-28',NULL,'Open','100000001'),(1019,'Periodicals Organization','2023-11-19','2023-11-29',NULL,'In Progress','100000001'),(1020,'Acquisitions Software Update','2023-11-20','2023-11-30',NULL,'Open','100000001');
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `TransactionId` int NOT NULL,
  `Borrowed` date NOT NULL,
  `Due` date NOT NULL,
  `Returned` date NOT NULL,
  `TransactionStatus` varchar(10) NOT NULL,
  PRIMARY KEY (`TransactionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (289161,'2023-07-11','2023-07-25','2023-07-25','Complete'),(383483,'2023-08-12','2023-09-12','2023-09-12','Complete'),(732783,'2023-05-03','2023-06-03','2022-01-01','Pending'),(812962,'2023-08-19','2023-09-17','2022-12-12','Pending'),(832893,'2023-10-05','2023-10-19','2023-10-18','Complete'),(837438,'2023-07-18','2023-08-18','2023-08-18','Complete'),(838328,'2023-10-02','2023-10-30','2023-10-30','Complete'),(882338,'2023-03-17','2023-04-17','2023-04-15','Complete'),(892392,'2023-09-23','2023-10-23','2020-02-02','Pending'),(892934,'2023-04-13','2023-04-27','2020-04-04','Pending');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url`
--

DROP TABLE IF EXISTS `url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `url` (
  `Url` varchar(255) NOT NULL,
  `PublicationId` int NOT NULL,
  PRIMARY KEY (`Url`,`PublicationId`),
  KEY `PublicationId` (`PublicationId`),
  CONSTRAINT `url_ibfk_1` FOREIGN KEY (`PublicationId`) REFERENCES `epublication` (`PublicationId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url`
--

LOCK TABLES `url` WRITE;
/*!40000 ALTER TABLE `url` DISABLE KEYS */;
INSERT INTO `url` VALUES ('http://www.example.com/publication/121283',121283),('http://www.example.com/publication/209164',209164),('http://www.example.com/publication/343463',343463),('http://www.example.com/publication/444423',444423),('http://www.example.com/publication/490890',490890),('http://www.example.com/publication/505702',505702),('http://www.example.com/publication/534021',534021),('http://www.example.com/publication/537723',537723),('http://www.example.com/publication/555777',555777),('http://www.example.com/publication/565643',565643),('http://www.example.com/publication/637683',637683),('http://www.example.com/publication/647193',647193),('http://www.example.com/publication/668877',668877),('http://www.example.com/publication/670282',670282),('http://www.example.com/publication/723822',723822),('http://www.example.com/publication/760023',760023),('http://www.example.com/publication/780733',780733),('http://www.example.com/publication/823893',823893),('http://www.example.com/publication/893181',893181),('http://www.example.com/publication/905143',905143);
/*!40000 ALTER TABLE `url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'library'
--
/*!50003 DROP PROCEDURE IF EXISTS `All_members_who_have_overdue_fines_before_a_certain_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `All_members_who_have_overdue_fines_before_a_certain_date`()
BEGIN
SELECT presides.MemberId, MemberStatus, Issued, Motive, Cost,  FirstName, LastName
FROM librarymember
JOIN presides ON librarymember.MemberId = presides.MemberId
JOIN transaction ON presides.TransactionId = transaction.TransactionId
JOIN fine ON transaction.TransactionId = fine.TransactionId
JOIN person  on librarymember.PersonId = person.PersonId

WHERE 
    Issued < '2019-11-27' AND
    Cost > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Find_available_rooms_on_date_within_a_capacity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Find_available_rooms_on_date_within_a_capacity`()
BEGIN
SELECT space.RoomNumber, space.capacity
FROM space
LEFT JOIN reserves ON space.RoomNumber = reserves.RoomNumber
AND '2023-11-15' BETWEEN reserves.start AND reserves.end
WHERE reserves.RoomNumber IS NULL
AND space.capacity >= 97
ORDER by space.RoomNumber ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Full_details_of_books_published_in_language_after_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Full_details_of_books_published_in_language_after_date`()
BEGIN
SELECT Title, book.ISBN, ISSN, Date, Pages, Language, volume,  edition, series
FROM Supplier
JOIN contributor on contributor.InstitutionId = supplier.InstitutionId
JOIN edits on contributor.ContributorId = edits.ContributorId
JOIN published on published.PublicationId = edits.PublicationId
JOIN publication on published.PublicationId = publication.PublicationId
JOIN book on published.ISBN = book.ISBN
WHERE Language = 'English' AND
Date >  '2023-4-20';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `List_of_All_Books_Borrowed_by_a_Specific Member` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `List_of_All_Books_Borrowed_by_a_Specific Member`()
BEGIN
SELECT published.ISBN, Title, Borrowed, Due, ItemCondition, Pages, volume,  edition, series, FirstName,  LastName
FROM transaction
JOIN presides ON transaction.TransactionId = presides.TransactionId
JOIN concerns ON transaction.TransactionId = concerns.TransactionId
JOIN stock ON concerns.StockId = stock.StockId
JOIN published ON stock.PublishedId = published.PublishedId
JOIN publication ON published.PublicationId = publication.PublicationId
JOIN book on published.ISBN = book.ISBN
JOIN  librarymember on  librarymember.MemberId  = presides.MemberId
JOIN person  on librarymember.PersonId = person.PersonId
WHERE presides.MemberId = 72316513783412;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `List_of_suppliers_providing_books_in_Language` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `List_of_suppliers_providing_books_in_Language`()
BEGIN
SELECT SupplierID, TYPE, Language, supplier.InstitutionId
FROM Supplier
JOIN contributor on contributor.InstitutionId = supplier.InstitutionId
JOIN edits on contributor.ContributorId = edits.ContributorId
JOIN published on published.PublicationId = edits.PublicationId
WHERE Language = 'Spanish';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Open_tickets_older_than_two_weeks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Open_tickets_older_than_two_weeks`()
BEGIN
SELECT TicketId, Issue, Start, memberStatus
FROM ticket
WHERE memberStatus = 'Open' AND
Start < DATE_SUB(CURDATE(), INTERVAL 14 DAY);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Three_Most_active_members_based_on_transactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Three_Most_active_members_based_on_transactions`()
BEGIN
SELECT librarymember.MemberID, COUNT(TransactionId) AS TotalTransactions, FirstName, LastName
FROM Presides
JOIN  librarymember on  librarymember.MemberId  = presides.MemberId
JOIN person  on librarymember.PersonId = person.PersonId
GROUP BY MemberID
ORDER BY TotalTransactions DESC
LIMIT 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Three_Most_popular_book_genres` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Three_Most_popular_book_genres`()
BEGIN
SELECT Genre, COUNT(*) AS Count
FROM Genre
GROUP BY Genre
ORDER BY Count DESC
LIMIT 3; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Total_fines_collected_each_month` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Total_fines_collected_each_month`()
BEGIN
SELECT SUM(Cost) AS TotalFines
FROM Fine
WHERE EXTRACT(MONTH FROM Issued) = 12 AND EXTRACT(YEAR FROM Issued) = 2021;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Upcoming_Library_Events_ordered_by_start_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Upcoming_Library_Events_ordered_by_start_date`()
BEGIN
SELECT Title, Start, End, RoomNumber
FROM Reserves
WHERE Start > '2023-11-15'
ORDER BY Start; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateStep1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStep1`()
BEGIN
UPDATE librarymember
SET MemberStatus = "ACTIVE"
WHERE MemberID = 89126376376365;

SELECT*
FROM librarymember
ORDER by MemberStatus;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateStep2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStep2`()
BEGIN
UPDATE librarymember
SET MemberStatus = 'INACTIVE'
WHERE ExpirationDate < CURRENT_DATE
AND MemberStatus = 'ACTIVE';

SELECT*
FROM librarymember
ORDER by MemberStatus;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-29 21:18:23
