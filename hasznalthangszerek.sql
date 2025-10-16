-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Okt 16. 17:05
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
-- Adatbázis: `hasznalthangszerek`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category`
--

CREATE TABLE `category` (
  `cname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `instrument`
--

CREATE TABLE `instrument` (
  `iid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `iname` varchar(100) NOT NULL,
  `cost` int(11) NOT NULL,
  `scname` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orderinfo`
--

CREATE TABLE `orderinfo` (
  `oid` int(11) NOT NULL,
  `dateOfPurchase` date NOT NULL,
  `deliveryCity` varchar(50) NOT NULL,
  `deliveryStreet` varchar(50) NOT NULL,
  `deliveryPC` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `iid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `subcategory`
--

CREATE TABLE `subcategory` (
  `scname` varchar(100) NOT NULL,
  `cname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `uid` int(11) NOT NULL,
  `uname` varchar(75) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pnumber` int(11) NOT NULL,
  `password` varchar(100) NOT NULL,
  `review` float NOT NULL,
  `postalcode` int(11) NOT NULL,
  `city` varchar(100) NOT NULL,
  `streetHnum` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`cname`);

--
-- A tábla indexei `instrument`
--
ALTER TABLE `instrument`
  ADD PRIMARY KEY (`iid`),
  ADD UNIQUE KEY `uid` (`uid`),
  ADD UNIQUE KEY `scname` (`scname`);

--
-- A tábla indexei `orderinfo`
--
ALTER TABLE `orderinfo`
  ADD PRIMARY KEY (`oid`),
  ADD UNIQUE KEY `sid` (`sid`),
  ADD UNIQUE KEY `cid` (`cid`),
  ADD UNIQUE KEY `iid` (`iid`);

--
-- A tábla indexei `subcategory`
--
ALTER TABLE `subcategory`
  ADD PRIMARY KEY (`scname`),
  ADD UNIQUE KEY `cname` (`cname`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `instrument`
--
ALTER TABLE `instrument`
  MODIFY `iid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `orderinfo`
--
ALTER TABLE `orderinfo`
  MODIFY `oid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `instrument`
--
ALTER TABLE `instrument`
  ADD CONSTRAINT `instrument_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
  ADD CONSTRAINT `instrument_ibfk_2` FOREIGN KEY (`scname`) REFERENCES `subcategory` (`scname`);

--
-- Megkötések a táblához `orderinfo`
--
ALTER TABLE `orderinfo`
  ADD CONSTRAINT `orderinfo_ibfk_1` FOREIGN KEY (`iid`) REFERENCES `instrument` (`iid`),
  ADD CONSTRAINT `orderinfo_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `user` (`uid`),
  ADD CONSTRAINT `orderinfo_ibfk_3` FOREIGN KEY (`cid`) REFERENCES `user` (`uid`);

--
-- Megkötések a táblához `subcategory`
--
ALTER TABLE `subcategory`
  ADD CONSTRAINT `subcategory_ibfk_1` FOREIGN KEY (`cname`) REFERENCES `category` (`cname`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
