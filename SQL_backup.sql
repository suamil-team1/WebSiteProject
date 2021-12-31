-- --------------------------------------------------------
-- 호스트:                          hj890825.cafe24.com
-- 서버 버전:                        10.1.13-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- hj890825 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `hj890825` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hj890825`;

-- 테이블 hj890825.basket 구조 내보내기
CREATE TABLE IF NOT EXISTS `basket` (
  `pNum` varchar(50) NOT NULL,
  `id` varchar(30) NOT NULL,
  `eaNum` varchar(50) NOT NULL,
  `sump` varchar(50) NOT NULL,
  `delivery` varchar(50) NOT NULL,
  `delVer` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pNum` (`pNum`),
  CONSTRAINT `basket_orderl_fk` FOREIGN KEY (`id`) REFERENCES `orderl` (`id`),
  CONSTRAINT `product_basket_fk` FOREIGN KEY (`pNum`) REFERENCES `product` (`pNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 hj890825.basket:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `basket` DISABLE KEYS */;
/*!40000 ALTER TABLE `basket` ENABLE KEYS */;

-- 테이블 hj890825.Model2Board 구조 내보내기
CREATE TABLE IF NOT EXISTS `Model2Board` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(30) NOT NULL,
  `title` varchar(300) NOT NULL,
  `content` text NOT NULL,
  `postdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ofile` varchar(200) DEFAULT NULL,
  `sfile` varchar(30) DEFAULT NULL,
  `visitcount` smallint(6) NOT NULL DEFAULT '0',
  `boardName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `fk_M2Board_pMember` (`id`),
  CONSTRAINT `fk_M2Board_pMember` FOREIGN KEY (`id`) REFERENCES `ProjectMember` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 hj890825.Model2Board:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `Model2Board` DISABLE KEYS */;
/*!40000 ALTER TABLE `Model2Board` ENABLE KEYS */;

-- 테이블 hj890825.Model2BoardCal 구조 내보내기
CREATE TABLE IF NOT EXISTS `Model2BoardCal` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(30) NOT NULL,
  `title` varchar(300) NOT NULL,
  `content` text NOT NULL,
  `pdate` date NOT NULL,
  `boardName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 hj890825.Model2BoardCal:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `Model2BoardCal` DISABLE KEYS */;
/*!40000 ALTER TABLE `Model2BoardCal` ENABLE KEYS */;

-- 테이블 hj890825.orderl 구조 내보내기
CREATE TABLE IF NOT EXISTS `orderl` (
  `id` varchar(30) NOT NULL,
  `address` text NOT NULL,
  `pay` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 hj890825.orderl:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `orderl` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderl` ENABLE KEYS */;

-- 테이블 hj890825.product 구조 내보내기
CREATE TABLE IF NOT EXISTS `product` (
  `pname` varchar(50) NOT NULL,
  `pcontent` varchar(200) NOT NULL,
  `pNum` varchar(50) NOT NULL,
  `price` varchar(50) NOT NULL,
  `imgfile` varchar(200) DEFAULT NULL,
  `POINT` varchar(50) NOT NULL,
  PRIMARY KEY (`pNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 hj890825.product:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`pname`, `pcontent`, `pNum`, `price`, `imgfile`, `POINT`) VALUES
	('참기름', '고소해요', '1', '30000원', NULL, '300포인트'),
	('간장', '짜요', '2', '20000원', NULL, '200포인트');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- 테이블 hj890825.ProjectMember 구조 내보내기
CREATE TABLE IF NOT EXISTS `ProjectMember` (
  `id` varchar(30) NOT NULL,
  `pass` varchar(40) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `regidate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tellNum` varchar(30) DEFAULT NULL,
  `mobile` varchar(30) NOT NULL,
  `address` text NOT NULL,
  `type` smallint(6) DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 hj890825.ProjectMember:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `ProjectMember` DISABLE KEYS */;
INSERT INTO `ProjectMember` (`id`, `pass`, `name`, `email`, `regidate`, `tellNum`, `mobile`, `address`, `type`) VALUES
	('admin', '1234', '어드민', 'tjcos3@hanmail.net', '2021-12-28 13:04:50', NULL, '010-1234-1111', '08505,서울 금천구 가산디지털2로 123,4층', 0);
/*!40000 ALTER TABLE `ProjectMember` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
