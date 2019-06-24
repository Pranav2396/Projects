-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 28, 2016 at 09:43 AM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `floods`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `Aid` int(11) NOT NULL,
  `AFname` varchar(50) NOT NULL,
  `ALname` varchar(50) NOT NULL,
  `AEmailAddress` varchar(50) NOT NULL,
  `APhoneNo` varchar(11) NOT NULL,
  `AUserName` varchar(50) NOT NULL,
  `APassword` varchar(50) NOT NULL,
  `AIsSuper` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Aid`, `AFname`, `ALname`, `AEmailAddress`, `APhoneNo`, `AUserName`, `APassword`, `AIsSuper`) VALUES
(1, 'Akshay', 'Rathore', 'akshay@gmail.com', '73187144201', 'akshay23', 'abc123', 1),
(2, 'Pranav', 'Murali', 'pranavcd.1996@gmail.com', '73187144201', 'akshay23', 'abc123', 0),
(3, 'Rohit', 'Burman', 'burman03.rohit@gmail.com', '73187144201', 'rohit03', 'abc123', 0);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE IF NOT EXISTS `departments` (
  `Dept_Id` int(11) NOT NULL,
  `Dept_Name` varchar(50) NOT NULL,
  `Dept_HeadFname` varchar(50) DEFAULT NULL,
  `Dept_HeadLName` varchar(50) NOT NULL,
  `PhoneNo` varchar(50) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Email_Id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`Dept_Id`, `Dept_Name`, `Dept_HeadFname`, `Dept_HeadLName`, `PhoneNo`, `Address`, `Email_Id`) VALUES
(1001, 'FireBrigade', 'Abhishek', 'Khuranna', '908284245', 'Bldg 1,White hills,Banglore', 'abhishek@gmail.com'),
(1002, 'Rescue', 'Mohammad', 'Ansari', '800232032', 'bldg 2,White Hills,Delhi', 'mohammad@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `flood`
--

CREATE TABLE IF NOT EXISTS `flood` (
  `Location` varchar(50) NOT NULL,
  `Time` datetime NOT NULL,
  `WaterLevel` int(3) NOT NULL,
  `Description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `flood`
--

INSERT INTO `flood` (`Location`, `Time`, `WaterLevel`, `Description`) VALUES
('Varanasi', '2016-02-02 11:40:25', 3, 'High water level.Please stay inside.'),
('Varanasi', '2016-01-06 15:16:02', 2, 'High water level.Please stay inside.');

-- --------------------------------------------------------

--
-- Table structure for table `foodavailability`
--

CREATE TABLE IF NOT EXISTS `foodavailability` (
  `FoodName` varchar(50) NOT NULL,
  `QuantityAvb` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `foodavailability`
--

INSERT INTO `foodavailability` (`FoodName`, `QuantityAvb`) VALUES
('Chapatti', 5),
('Biscuits', 5);

-- --------------------------------------------------------

--
-- Table structure for table `food_donation`
--

CREATE TABLE IF NOT EXISTS `food_donation` (
  `Did` int(11) NOT NULL,
  `UPhoneNo` varchar(11) NOT NULL,
  `UEmailAddress` varchar(50) NOT NULL,
  `FoodName` varchar(50) NOT NULL,
  `Quantity` int(15) NOT NULL,
  `Status` tinyint(1) DEFAULT NULL,
  `Remark` varchar(50) DEFAULT NULL,
  `TimeSubmitted` datetime DEFAULT NULL,
  `TimeReceived` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `food_donation`
--

INSERT INTO `food_donation` (`Did`, `UPhoneNo`, `UEmailAddress`, `FoodName`, `Quantity`, `Status`, `Remark`, `TimeSubmitted`, `TimeReceived`) VALUES
(1, '1234567891', 'Madhan@yahoo.com', 'Chips', 5, 0, '', '2016-02-28 09:01:01', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `money_donation`
--

CREATE TABLE IF NOT EXISTS `money_donation` (
  `Mid` int(11) NOT NULL,
  `UPhoneNo` varchar(50) NOT NULL,
  `UEmailAddress` varchar(50) NOT NULL,
  `Amount` int(10) NOT NULL,
  `Status` tinyint(1) NOT NULL,
  `Remark` varchar(50) NOT NULL,
  `TimeSubmitted` datetime DEFAULT NULL,
  `TimeReceived` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `money_donation`
--

INSERT INTO `money_donation` (`Mid`, `UPhoneNo`, `UEmailAddress`, `Amount`, `Status`, `Remark`, `TimeSubmitted`, `TimeReceived`) VALUES
(1, '1234567891', 'Madhan@yahoo.com', 2000, 0, '', '2016-02-28 09:01:01', '0000-00-00 00:00:00'),
(2, '1234567891', 'Madhan@yahoo.com', 2000, 0, '', '2016-02-28 00:00:00', '0000-00-00 00:00:00'),
(3, '1234567891', 'Madhan@yahoo.com', 2000, 0, '', '2016-02-28 13:37:43', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `storage`
--

CREATE TABLE IF NOT EXISTS `storage` (
  `StorageId` varchar(10) NOT NULL,
  `Location` varchar(50) NOT NULL,
  `IsCapAvb` tinyint(1) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `LocationName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `storage`
--

INSERT INTO `storage` (`StorageId`, `Location`, `IsCapAvb`, `City`, `State`, `Country`, `LocationName`) VALUES
('101', 'Bldg 1,Grant Road', 1, 'Mumbai', 'Maharashtra', 'India', 'NationStorage'),
('102', 'Bldg 2.Lamington Road', 0, 'NewDelhi', 'Delhi', 'India', 'RamStorage'),
('103', 'Bldg2,floor 2,St.Anthony Road', 1, 'Mumbai', 'Maharashtra', 'India', 'SatyamStorage');

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE IF NOT EXISTS `user_details` (
  `PhoneNo` varchar(11) NOT NULL,
  `EmailAddress` varchar(50) NOT NULL,
  `Fname` varchar(50) NOT NULL,
  `Lname` varchar(50) NOT NULL,
  `Age` int(2) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `MoneyD` tinyint(1) NOT NULL,
  `FoodD` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`PhoneNo`, `EmailAddress`, `Fname`, `Lname`, `Age`, `Address`, `MoneyD`, `FoodD`) VALUES
('1234567891', 'Madhan@yahoo.com', 'Madhan', 'm', 21, 'sad', 1, 1),
('1234567891', 'rajesh@yahoo.com', 'Rajesh', 'N', 21, 'sadas', 1, 1),
('8222630245', 'pranavcd.1996@gmail.com', 'Pranav', 'Murali', 20, 'Bldg 902,Silver Road,Red Woods,Mulund(W)', 1, 1),
('8224630345', 'akshay.mhatre@gmail.com', 'Akshay', 'Mhatre', 21, 'Bldg 102,LBS Road,Swapna Society,Ghatkopar(W)', 0, 1),
('9232630215', 'burman03.rohit@gmail.com', 'Rohit', 'Burman', 20, 'Bldg 302,Gold Road,Blue Woods,Thane(W)', 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Aid`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`Dept_Id`);

--
-- Indexes for table `food_donation`
--
ALTER TABLE `food_donation`
  ADD PRIMARY KEY (`Did`,`UPhoneNo`,`UEmailAddress`);

--
-- Indexes for table `money_donation`
--
ALTER TABLE `money_donation`
  ADD PRIMARY KEY (`Mid`,`UPhoneNo`,`UEmailAddress`);

--
-- Indexes for table `storage`
--
ALTER TABLE `storage`
  ADD PRIMARY KEY (`StorageId`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`PhoneNo`,`EmailAddress`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `food_donation`
--
ALTER TABLE `food_donation`
  MODIFY `Did` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `money_donation`
--
ALTER TABLE `money_donation`
  MODIFY `Mid` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
