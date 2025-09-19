-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Sze 19. 10:38
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `hasznalt_hangszerek`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `customer`
--

CREATE TABLE `customer` (
  `CID` int(11) NOT NULL,
  `CNAME` varchar(70) NOT NULL,
  `EMAIL` varchar(70) NOT NULL,
  `PHONENUMBER` int(11) NOT NULL,
  `STREET` varchar(50) NOT NULL,
  `COUNTRY` varchar(50) NOT NULL,
  `POSTALCODE` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `delivery`
--

CREATE TABLE `delivery` (
  `DID` int(11) NOT NULL,
  `GLStoHOME` tinyint(1) NOT NULL,
  `GLSPOINT` tinyint(1) NOT NULL,
  `FOXPOST` tinyint(1) NOT NULL,
  `EXPRESSONEtoHOME` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `instrument`
--

CREATE TABLE `instrument` (
  `IID` int(11) NOT NULL,
  `INAME` varchar(50) NOT NULL,
  `BRAND` varchar(50) NOT NULL,
  `CATEGORY` varchar(50) NOT NULL,
  `SUBCATEGORY` varchar(50) NOT NULL,
  `SPECS` varchar(200) NOT NULL,
  `COST` int(11) NOT NULL,
  `SID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `purchase`
--

CREATE TABLE `purchase` (
  `PID` int(11) NOT NULL,
  `DATEOFPURCHASE` datetime NOT NULL,
  `PAYMENTMETHOD` varchar(50) NOT NULL,
  `CID` int(11) NOT NULL,
  `DID` int(11) NOT NULL,
  `IID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `seller`
--

CREATE TABLE `seller` (
  `SID` int(11) NOT NULL,
  `SNAME` int(70) NOT NULL,
  `EMAIL` int(70) NOT NULL,
  `PHONENUMBER` int(30) NOT NULL,
  `STREET` varchar(50) NOT NULL,
  `COUNTRY` varchar(50) NOT NULL,
  `POSTALCODE` int(11) NOT NULL,
  `REVIEW` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CID`);

--
-- A tábla indexei `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`DID`);

--
-- A tábla indexei `instrument`
--
ALTER TABLE `instrument`
  ADD PRIMARY KEY (`IID`),
  ADD KEY `SID` (`SID`);

--
-- A tábla indexei `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`PID`),
  ADD KEY `CID` (`CID`),
  ADD KEY `DID` (`DID`),
  ADD KEY `IID` (`IID`);

--
-- A tábla indexei `seller`
--
ALTER TABLE `seller`
  ADD PRIMARY KEY (`SID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `customer`
--
ALTER TABLE `customer`
  MODIFY `CID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `delivery`
--
ALTER TABLE `delivery`
  MODIFY `DID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `instrument`
--
ALTER TABLE `instrument`
  MODIFY `IID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `purchase`
--
ALTER TABLE `purchase`
  MODIFY `PID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `seller`
--
ALTER TABLE `seller`
  MODIFY `SID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `instrument`
--
ALTER TABLE `instrument`
  ADD CONSTRAINT `instrument_ibfk_1` FOREIGN KEY (`SID`) REFERENCES `seller` (`SID`);

--
-- Megkötések a táblához `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`DID`) REFERENCES `delivery` (`DID`),
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`CID`) REFERENCES `customer` (`CID`),
  ADD CONSTRAINT `purchase_ibfk_3` FOREIGN KEY (`IID`) REFERENCES `instrument` (`IID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
