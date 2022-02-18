-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09-Dez-2019 às 17:30
-- Versão do servidor: 10.4.6-MariaDB
-- versão do PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sea`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id`, `nome`) VALUES
(3, 'Bolos'),
(2, 'Grosso'),
(4, 'Hortaliças'),
(1, 'Laticínios ');

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
  `id` int(11) NOT NULL,
  `nome_fantasia` varchar(100) NOT NULL,
  `razao_social` varchar(100) NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telefone` varchar(14) DEFAULT NULL,
  `celular` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `fornecedor`
--

INSERT INTO `fornecedor` (`id`, `nome_fantasia`, `razao_social`, `cnpj`, `email`, `telefone`, `celular`) VALUES
(1, 'Sertão Seridó', 'Sertão Seridó LTDA', '19.473.619/0001-41', 'sertao@sertao.com', '(00) 0000-0000', '(00) 00000-0000'),
(2, 'Atacadao Vicunha', 'Atacadao LTDA', '98.980.102/9810-92', 'atacadao@atacadao.com', '(78) 3687-6376', '(62) 51765-2712'),
(3, 'Rede Mais Venancio', 'Rede Mais LTDA', '89.237.928/7398-72', 'rede@rede.com', '(83) 4769-3246', '(34) 76387-6487'),
(4, 'Quandu', 'Quandu Bolos ', '89.438.947/9837-48', 'quandu@quandu.com', '(84) 3433-9999', '(84) 00000-0000');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedido`
--

CREATE TABLE `pedido` (
  `id` int(11) NOT NULL,
  `data` varchar(10) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pedido`
--

INSERT INTO `pedido` (`id`, `data`, `usuario_id`, `quantidade`, `produto_id`) VALUES
(1, '09/12/2019', 3, 3, 1),
(2, '09/12/2019', 2, 2, 1),
(4, '09/12/2019', 2, 1, 1),
(5, '09/12/2019', 3, 3, 2),
(6, '09/12/2019', 3, 4, 4),
(7, '09/12/2019', 3, 10, 5),
(8, '09/12/2019', 2, 12, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `fornecedor_id` int(11) NOT NULL,
  `estoque` int(11) NOT NULL,
  `validade` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`id`, `nome`, `categoria_id`, `fornecedor_id`, `estoque`, `validade`) VALUES
(1, 'Leite sem lactose', 1, 1, 2, '20/12/2019'),
(2, 'Arroz', 2, 2, 27, '20/12/19'),
(3, 'Coentro', 4, 3, 30, '18/12/19'),
(4, 'Cebola', 4, 3, 1, '15/12/19'),
(5, 'Bolo de milho', 3, 4, 40, '14/12/19'),
(6, 'Bolo de Ovos', 3, 4, 39, '17/12/19'),
(7, 'Cuscuz ', 2, 2, 88, '30/12/20');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `matricula` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `tipo` varchar(45) NOT NULL,
  `accessToken` varchar(100) DEFAULT NULL,
  `authKey` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `user`
--

INSERT INTO `user` (`id`, `nome`, `matricula`, `email`, `senha`, `tipo`, `accessToken`, `authKey`) VALUES
(1, 'Administrador', 'admin', 'admin@email.com', '$2y$13$RzIEJr5K90abmf7r72IYgOZZcduxwXUVtrzBlg/heUYjBpO/oH0MC', 'admin', 'K5aVCPP0anW_nDsUXMkXwynNdaYzn7a7DVj1mdEsMWXZ0mx2eLJurSlNO-YV9L-7aIL8YwYxmK7wu8tEgTYvt27wzBTkCP6hX2qa', 'TOfBwcG0gQjCMhvp8CuLthT840HMOGWZK9ASpYXAD6HjC6HMMvfhMLlfEEA42exZBrnI9jp5_Qr1HDuf1pctKKF7Xpqfi20BtuPV'),
(2, 'Ravana', '20161038060009', 'ravana@ravana.com', '$2y$13$8tp1i/mbwcK12SyQjltaieC.MRYlb0/p9v6KTH6nVdImTAYkzDuEa', 'Bolsista', 'mdOfJd48xN6iJmOI0BcFkeOXgtOgvFTjR8e2M4yanYXn9stWajMThg0n-3NwyRvjp-QlOQ04OL-TnRPWTVXK-HaN5mQhWXqg-xw2', 'h-E0wg7p6sDM9NSm1HVJcRkO1rgJE0xanxD2ns0lsuS5UkLW5w-Z8GF2avzefGG2i1IzqKS-8hu2kONDV3q7Jv60d1ohrz-KHNVy'),
(3, 'Keylly', '123456', 'keylly@keylly.com', '$2y$13$V3XUFn5oQhA3l3riFSv2tODFM.mo/fjA5aOqDUrH1Cgl6Rlg3KxtG', 'Nutricionista', 'z_wxpehAFeHgix2q6vIfmPrMJgnR0boKbMnYreX1uH9-Sv5aln4NOHVAYP1eFim7rHGnALuSgAzcGjNFs7JX9hFDDTCNILSJ4bR2', 'bMBPHhxGzPkFQTBtbti7Tv0Osb7Q-wxPcJ2ECICgk42RhdI_S1b-T9I2lGy9vnR51jovOERiVyN2urwHruk8FQwNre-ggCTCCh1Z');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome_UNIQUE` (`nome`);

--
-- Índices para tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnpj_UNIQUE` (`cnpj`);

--
-- Índices para tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pedido_usuario1_idx` (`usuario_id`),
  ADD KEY `fk_pedido_produto1_idx` (`produto_id`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_produto_categoria_idx` (`categoria_id`),
  ADD KEY `fk_produto_fornecedor1_idx` (`fornecedor_id`);

--
-- Índices para tabela `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricula_UNIQUE` (`matricula`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_produto1` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_produto_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_produto_fornecedor1` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
