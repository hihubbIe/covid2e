-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 29 déc. 2021 à 18:15
-- Version du serveur :  5.7.26
-- Version de PHP :  7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `covid`
--

-- --------------------------------------------------------

--
-- Structure de la table `friend`
--

DROP TABLE IF EXISTS `friend`;
CREATE TABLE IF NOT EXISTS `friend` (
  `friend1` varchar(64) NOT NULL,
  `friend2` varchar(64) NOT NULL,
  `update` date NOT NULL,
  `status` int(32) NOT NULL,
  PRIMARY KEY (`friend1`,`friend2`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `friend`
--

INSERT INTO `friend` (`friend1`, `friend2`, `update`, `status`) VALUES
('1', '6', '2021-12-29', 1),
('2\r\n', '3', '2021-12-14', 1);

-- --------------------------------------------------------

--
-- Structure de la table `friendstatus`
--

DROP TABLE IF EXISTS `friendstatus`;
CREATE TABLE IF NOT EXISTS `friendstatus` (
  `id` varchar(64) NOT NULL,
  `text` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `notification`
--

DROP TABLE IF EXISTS `notification`;
CREATE TABLE IF NOT EXISTS `notification` (
  `id` varchar(64) NOT NULL,
  `user` varchar(64) NOT NULL,
  `receivedDate` date NOT NULL,
  `content` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user` (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `notification`
--

INSERT INTO `notification` (`id`, `user`, `receivedDate`, `content`) VALUES
('1', '2\r\n', '2021-12-29', 'daisuke57 vous a retiré de sa liste d amis.'),
('4', '3', '2021-12-29', '[ADD]-1 | daisuke57 veut vous ajouter en ami');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(0, 'admin'),
(1, 'user');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` varchar(64) NOT NULL,
  `login` varchar(64) NOT NULL,
  `password` varchar(256) NOT NULL,
  `name` varchar(64) NOT NULL,
  `firstName` varchar(64) NOT NULL,
  `birthday` date NOT NULL,
  `role` int(64) NOT NULL,
  `photo` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `login`, `password`, `name`, `firstName`, `birthday`, `role`, `photo`) VALUES
('1', 'daisuke57', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Dao', 'Denis', '2021-01-04', 0, 'https://static.hitek.fr/img/actualite/2017/07/05/tumblr-static-tumblr-static-cuwbu6znhdwgwkso84kwc448-640.png'),
('2\r\n', 'doudou', 'sfqsfqsgqgqgsdfd', 'Valchier', 'Lagraves', '2021-12-08', 0, NULL),
('3', 'Groudloud', 'aelkkfgdsngjoqdgkjqfqfqms,', 'Shao', 'Khanh', '2021-12-06', 0, NULL),
('4', 'daisukette', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Son', 'Goku', '2021-12-22', 1, NULL),
('5', 'Lamaillequimaille', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Lamaille', 'quimaille', '2021-12-26', 1, NULL),
('6', 'dak', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'Dao', 'Douloud', '2000-01-04', 1, 'http://images6.fanpop.com/image/photos/34300000/homer-simpson-homer-simpson-34387502-168-200.png');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_role` FOREIGN KEY (`role`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
