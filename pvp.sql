-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18-Fev-2021 às 17:41
-- Versão do servidor: 10.4.16-MariaDB
-- versão do PHP: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `pvp`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_attachs`
--

CREATE TABLE `vrp_attachs` (
  `user_id` int(11) NOT NULL,
  `grip` int(11) NOT NULL DEFAULT 0,
  `lanterna` int(11) NOT NULL DEFAULT 0,
  `compensador` int(11) NOT NULL DEFAULT 0,
  `silenciador` int(11) NOT NULL DEFAULT 0,
  `pente` int(11) NOT NULL DEFAULT 0,
  `miraS` int(11) NOT NULL DEFAULT 0,
  `miraA` int(11) NOT NULL DEFAULT 0,
  `tracante` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vrp_infos`
--

CREATE TABLE `vrp_infos` (
  `user_id` int(11) NOT NULL,
  `kills` int(255) NOT NULL,
  `deaths` int(255) NOT NULL,
  `coins` int(255) NOT NULL,
  `kd` float NOT NULL DEFAULT 0,
  `particles` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
