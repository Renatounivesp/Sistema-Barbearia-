-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 25/08/2025 às 16:24
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `barbearia`
--
CREATE DATABASE IF NOT EXISTS `barbearia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `barbearia`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL,
  `servico` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agendamentos`
--

INSERT INTO `agendamentos` (`id`, `cliente_id`, `data`, `hora`, `servico`) VALUES
(26, 39, '2025-08-13', '12:00:00', 'cabelo ');

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(10) NOT NULL,
  `nome` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) NOT NULL,
  `telefone` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `email`, `telefone`) VALUES
(39, 'marcos', 'marcos@hotmail.com', '1298564574');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`) VALUES
(1, 'Admin', 'admin@barbearia.com', '1234');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD CONSTRAINT `agendamentos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`);
--
-- Banco de dados: `barbearia_db`
--
CREATE DATABASE IF NOT EXISTS `barbearia_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `barbearia_db`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_barbeiro` int(11) NOT NULL,
  `id_servico` int(11) NOT NULL,
  `data_hora` datetime NOT NULL,
  `status` enum('agendado','concluido','cancelado') DEFAULT 'agendado',
  `observacoes` text DEFAULT NULL,
  `data_agendamento` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `barbeiros`
--

CREATE TABLE `barbeiros` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `especialidade` varchar(255) DEFAULT NULL,
  `biografia` text DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `barbeiros`
--

INSERT INTO `barbeiros` (`id`, `id_usuario`, `especialidade`, `biografia`, `foto`) VALUES
(1, 2, 'Cortes modernos e barba', 'Profissional com mais de 10 anos de experiência em barbearia.', 'joao.jpg');

-- --------------------------------------------------------

--
-- Estrutura para tabela `horarios_especiais`
--

CREATE TABLE `horarios_especiais` (
  `id` int(11) NOT NULL,
  `id_barbeiro` int(11) DEFAULT NULL,
  `data` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  `tipo` enum('folga','horario_estendido') NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `servicos`
--

CREATE TABLE `servicos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `duracao` int(11) NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `servicos`
--

INSERT INTO `servicos` (`id`, `nome`, `descricao`, `preco`, `duracao`, `imagem`, `ativo`) VALUES
(1, 'Corte de Cabelo', 'Corte de cabelo tradicional masculino', 35.00, 30, 'corte.jpg', 1),
(2, 'Barba', 'Aparar e modelar barba com toalha quente', 25.00, 20, 'barba.jpg', 1),
(3, 'Corte + Barba', 'Corte de cabelo e barba completa', 55.00, 50, 'corte_barba.jpg', 1),
(4, 'Hidratação', 'Tratamento para revitalizar os cabelos', 45.00, 40, 'hidratacao.jpg', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `tipo` enum('cliente','barbeiro','admin') NOT NULL DEFAULT 'cliente',
  `data_cadastro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `telefone`, `tipo`, `data_cadastro`) VALUES
(1, 'Administrador', 'admin@barbearia.com', '$2y$10$isnXUFdsm0bSYkhE1orlderRE9cZv4skl4gtcFfpB8LfDU9jsyV/.', NULL, 'admin', '2025-04-23 22:49:04'),
(2, 'João Silva', 'joao@barbearia.com', '$2y$10$GtO.XBl.q/ynwl.2JDr0JesAwcXSg.dMcGzMMxv.7Vqlc2ZXh5gR.', '(11) 98765-4321', 'barbeiro', '2025-04-23 22:49:04'),
(3, 'Pedro Oliveira', 'pedro@email.com', '$2y$10$9fsqmljE2wEW2Mu81dDn..ibl9Hbe.5M4r3vzWaBQazHwsTJXb74.', '(11) 91234-5678', 'cliente', '2025-04-23 22:49:04');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_barbeiro` (`id_barbeiro`),
  ADD KEY `id_servico` (`id_servico`);

--
-- Índices de tabela `barbeiros`
--
ALTER TABLE `barbeiros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Índices de tabela `horarios_especiais`
--
ALTER TABLE `horarios_especiais`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_barbeiro` (`id_barbeiro`);

--
-- Índices de tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `barbeiros`
--
ALTER TABLE `barbeiros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `horarios_especiais`
--
ALTER TABLE `horarios_especiais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD CONSTRAINT `agendamentos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `agendamentos_ibfk_2` FOREIGN KEY (`id_barbeiro`) REFERENCES `barbeiros` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `agendamentos_ibfk_3` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `barbeiros`
--
ALTER TABLE `barbeiros`
  ADD CONSTRAINT `barbeiros_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `horarios_especiais`
--
ALTER TABLE `horarios_especiais`
  ADD CONSTRAINT `horarios_especiais_ibfk_1` FOREIGN KEY (`id_barbeiro`) REFERENCES `barbeiros` (`id`) ON DELETE CASCADE;
--
-- Banco de dados: `barbearia_nova_era_db`
--
CREATE DATABASE IF NOT EXISTS `barbearia_nova_era_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `barbearia_nova_era_db`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `data_hora` datetime NOT NULL,
  `servico` varchar(100) NOT NULL,
  `barbeiro` varchar(100) NOT NULL,
  `observacoes` text NOT NULL,
  `data_agendamento` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `data_nascimento` date NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `email`, `telefone`, `data_nascimento`, `cidade`, `endereco`, `data_cadastro`) VALUES
(15, 'renato leme', 'renato.flair@hotmail.com', '12981348661', '2025-12-08', 'sp', 'prestes maia 858', '2025-03-29 21:47:33'),
(17, 'renato leme', 'renatooo.flair@hotmail.com', '12981348661', '2025-02-02', 'sp', 'prestes maia 858', '2025-03-30 00:54:29');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `senha` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cliente_id` (`cliente_id`);

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD CONSTRAINT `fk_cliente_agendamento` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`);
--
-- Banco de dados: `calculadora_ifood`
--
CREATE DATABASE IF NOT EXISTS `calculadora_ifood` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `calculadora_ifood`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `dados`
--

CREATE TABLE `dados` (
  `id` int(11) NOT NULL,
  `custo` decimal(10,2) DEFAULT NULL,
  `comissao` decimal(5,2) DEFAULT NULL,
  `mensalidade` decimal(10,2) DEFAULT NULL,
  `vendas` int(11) DEFAULT NULL,
  `lucro` decimal(10,2) DEFAULT NULL,
  `entregaPor` varchar(20) DEFAULT NULL,
  `taxaEntrega` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `data_cadastro`) VALUES
(1, 'Renato leme', 'leme@hotmail.com', '$2y$10$TOI/iz8Kfe4DLDN3XWj9z.iQ2efCaI13HA4Eezd8ml75YEBJobGCy', '2025-05-03 22:33:53'),
(3, 'marcos', 'marcos@hotmail.com', '$2y$10$jc8KeCm/ZQ5ngoic9Lmbu.BPKVDPEdWw5VN.x.pRWdkCXaQvb61DS', '2025-05-03 22:34:23');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `dados`
--
ALTER TABLE `dados`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `dados`
--
ALTER TABLE `dados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Banco de dados: `clinica_odontologica`
--
CREATE DATABASE IF NOT EXISTS `clinica_odontologica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `clinica_odontologica`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_dentista` int(11) NOT NULL,
  `data` date NOT NULL,
  `horario` time NOT NULL,
  `status` varchar(20) DEFAULT 'pendente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('cliente','dentista','recepcionista') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `tipo`) VALUES
(1, 'Cliente Teste', 'cliente@teste.com', '$2b$12$uCYmFyRZRZPJiS5olZKmuOgaRviEAJKutFebw6YAXMJH9kTXBwd4m', 'cliente'),
(2, 'Dentista Teste', 'dentista@teste.com', '$2b$12$V3xKpzCcqOLA5KPF3HAY4.zwA.c35k63MVkPawF4U2Motf7.fNROy', 'dentista'),
(3, 'Recepcionista Teste', 'recepcionista@teste.com', '$2b$12$CR8QqQNX65Kfyo7JipdLpelhxP6LWQgDFMeB7N8wW0A9SxCREPhfW', 'recepcionista');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_dentista` (`id_dentista`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD CONSTRAINT `agendamentos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `agendamentos_ibfk_2` FOREIGN KEY (`id_dentista`) REFERENCES `usuarios` (`id`);
--
-- Banco de dados: `sistema_agendamento`
--
CREATE DATABASE IF NOT EXISTS `sistema_agendamento` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sistema_agendamento`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `servico` varchar(100) NOT NULL,
  `data_agendamento` date NOT NULL,
  `hora_agendamento` time NOT NULL,
  `status` enum('pendente','confirmado','cancelado') NOT NULL DEFAULT 'pendente',
  `observacoes` text DEFAULT NULL,
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agendamentos`
--

INSERT INTO `agendamentos` (`id`, `usuario_id`, `servico`, `data_agendamento`, `hora_agendamento`, `status`, `observacoes`, `data_criacao`) VALUES
(1, 2, 'Consulta Regular', '2025-04-25', '09:00:00', 'cancelado', 'calma calabreso', '2025-04-23 23:07:40'),
(2, 3, 'manutenção', '2025-04-25', '14:00:00', 'cancelado', '', '2025-04-24 14:25:52'),
(3, 4, 'Consulta Completa', '2025-04-25', '10:00:00', 'cancelado', '', '2025-04-24 19:41:22'),
(4, 1, 'Consulta Regular', '2025-04-25', '08:00:00', 'cancelado', 'ygygyggy', '2025-04-24 19:42:58'),
(5, 4, 'manutenção', '2025-04-25', '09:00:00', 'cancelado', '', '2025-04-24 21:39:54'),
(6, 5, 'limpeza', '2025-04-26', '09:00:00', 'cancelado', '', '2025-04-25 01:45:06');

-- --------------------------------------------------------

--
-- Estrutura para tabela `servicos`
--

CREATE TABLE `servicos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `duracao` int(11) NOT NULL,
  `descricao` text DEFAULT NULL,
  `status` enum('ativo','inativo') NOT NULL DEFAULT 'ativo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `servicos`
--

INSERT INTO `servicos` (`id`, `nome`, `duracao`, `descricao`, `status`) VALUES
(1, 'Consulta Regular', 30, 'Consulta padrão de 30 minutos', 'ativo'),
(2, 'Consulta Completa', 60, 'Consulta completa de 1 hora', 'ativo'),
(3, 'Atendimento Rápido', 15, 'Atendimento rápido para questões simples', 'ativo'),
(4, 'limpeza', 30, '', 'ativo'),
(5, 'manutenção', 30, '', 'ativo'),
(6, 'canal', 30, '', 'ativo');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `tipo` enum('cliente','admin') NOT NULL DEFAULT 'cliente',
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `telefone`, `tipo`, `data_cadastro`) VALUES
(1, 'Administrador', 'admin@sistema.com', '$2y$10$FyhruBFPrXshtc5TLbESt.3G2UNyEFmD9IrqCeLQox5e.0eiWfRfG', '(00) 00000-0000', 'admin', '2025-04-23 22:44:31'),
(2, 'Renato leme', 'renato.flair@hotmail.com', '$2y$10$Xxkj1dVhwWq1BBEiKF2c.u7.Do.8G9Nj80HOUO.O8dgfHMlNWqfLa', '12981348331', 'cliente', '2025-04-23 23:06:51'),
(3, 'paulo', 'paulo@hotmail.com', '$2y$10$32raiVetDzZOjtl6PGR8H.Yx2W7r/zNfc/.I7lHDVrMdCJbobRc4u', '1298654562', 'cliente', '2025-04-24 14:20:40'),
(4, 'marcos', 'marcos@hotmail.com', '$2y$10$S8VevqHQpMexZf/VgXTUveOgu5kWCpciC49fyV4TFlIrIAeeKTCCi', '1298564574', 'cliente', '2025-04-24 19:40:39'),
(5, 'lemes', 'leme@hotmail.com', '$2y$10$rm5oF9xwETZf6sDz02OiWOaFuGO5fekxGbwK7r2c8BT8xyvrw1cvq', '129696525', 'cliente', '2025-04-24 23:48:46');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD CONSTRAINT `agendamentos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);
--
-- Banco de dados: `sistema_piscinas`
--
CREATE DATABASE IF NOT EXISTS `sistema_piscinas` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `sistema_piscinas`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `analises`
--

CREATE TABLE `analises` (
  `id` int(11) NOT NULL,
  `piscina_id` int(11) NOT NULL,
  `servico_id` int(11) DEFAULT NULL,
  `data_analise` datetime NOT NULL DEFAULT current_timestamp(),
  `ph` decimal(4,2) DEFAULT NULL COMMENT 'Valor do pH (0-14)',
  `cloro` decimal(4,2) DEFAULT NULL COMMENT 'Valor do Cloro (ppm)',
  `alcalinidade` int(11) DEFAULT NULL COMMENT 'Alcalinidade (ppm)',
  `temperatura` decimal(4,1) DEFAULT NULL COMMENT 'Temperatura em °C',
  `turbidez` enum('transparente','levemente_turva','turva','muito_turva') DEFAULT 'transparente',
  `observacoes` text DEFAULT NULL,
  `tecnico_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `tipo` enum('residencial','comercial','condominio') NOT NULL,
  `cpf_cnpj` varchar(20) DEFAULT NULL,
  `endereco` varchar(200) NOT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `telefone` varchar(15) NOT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `data_cadastro` datetime NOT NULL DEFAULT current_timestamp(),
  `ativo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `tipo`, `cpf_cnpj`, `endereco`, `bairro`, `cidade`, `estado`, `cep`, `telefone`, `celular`, `email`, `observacoes`, `data_cadastro`, `ativo`) VALUES
(1, 'Condomínio Águas Claras', 'condominio', '12.345.678/0001-90', 'Av. Principal, 1500', 'Centro', 'São Paulo', 'SP', '01000-000', '(11) 3456-7890', '(11) 98765-4321', 'contato@aguasclaras.com', 'Condomínio com 3 piscinas', '2025-04-23 23:52:44', 1),
(2, 'Residencial Bela Vista', 'condominio', '23.456.789/0001-01', 'Rua das Flores, 500', 'Jardim Paulista', 'São Paulo', 'SP', '01400-000', '(11) 3333-4444', '(11) 97777-8888', 'contato@belavista.com', 'Condomínio de alto padrão', '2025-04-23 23:52:44', 1),
(3, 'Academia Swim', 'comercial', '34.567.890/0001-12', 'Rua Esporte, 100', 'Moema', 'São Paulo', 'SP', '04500-000', '(11) 2222-3333', '(11) 96666-7777', 'contato@academiaswim.com', 'Academia com piscina olímpica', '2025-04-23 23:52:44', 1),
(4, 'Hotel Maravilha', 'comercial', '45.678.901/0001-23', 'Av. Beira Mar, 1000', 'Praia Grande', 'Santos', 'SP', '11000-000', '(13) 3333-5555', '(13) 98888-9999', 'reservas@hotelmaravilha.com', 'Hotel com 2 piscinas', '2025-04-23 23:52:44', 1),
(5, 'Maria Silva', 'residencial', '123.456.789-00', 'Rua Boa Vista, 123', 'Jardins', 'São Paulo', 'SP', '01300-000', '(11) 2345-6789', '(11) 95555-6666', 'mariasilva@email.com', 'Cliente residencial', '2025-04-23 23:52:44', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `contratos`
--

CREATE TABLE `contratos` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `tipo_contrato` enum('semanal','quinzenal','mensal','personalizado') NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date DEFAULT NULL,
  `valor_mensal` decimal(10,2) NOT NULL,
  `dia_vencimento` tinyint(4) NOT NULL COMMENT 'Dia do mês para vencimento',
  `status` enum('ativo','suspenso','cancelado','finalizado') NOT NULL DEFAULT 'ativo',
  `observacoes` text DEFAULT NULL,
  `data_cadastro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `contrato_piscinas`
--

CREATE TABLE `contrato_piscinas` (
  `contrato_id` int(11) NOT NULL,
  `piscina_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `itens_servico`
--

CREATE TABLE `itens_servico` (
  `id` int(11) NOT NULL,
  `servico_id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `quantidade` decimal(10,2) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `movimentacao_estoque`
--

CREATE TABLE `movimentacao_estoque` (
  `id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `tipo_movimento` enum('entrada','saida','ajuste') NOT NULL,
  `quantidade` decimal(10,2) NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `data_movimento` datetime NOT NULL DEFAULT current_timestamp(),
  `servico_id` int(11) DEFAULT NULL COMMENT 'ID do serviço associado, se aplicável',
  `observacao` text DEFAULT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `piscinas`
--

CREATE TABLE `piscinas` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `tipo` enum('alvenaria','fibra','vinil') NOT NULL,
  `formato` varchar(50) NOT NULL,
  `volume` decimal(10,2) NOT NULL COMMENT 'Volume em m³',
  `largura` decimal(6,2) DEFAULT NULL COMMENT 'Largura em metros',
  `comprimento` decimal(6,2) DEFAULT NULL COMMENT 'Comprimento em metros',
  `profundidade_minima` decimal(4,2) DEFAULT NULL COMMENT 'Profundidade mínima em metros',
  `profundidade_maxima` decimal(4,2) DEFAULT NULL COMMENT 'Profundidade máxima em metros',
  `tem_aquecimento` tinyint(1) NOT NULL DEFAULT 0,
  `tem_iluminacao` tinyint(1) NOT NULL DEFAULT 0,
  `tem_cascata` tinyint(1) NOT NULL DEFAULT 0,
  `tem_hidromassagem` tinyint(1) NOT NULL DEFAULT 0,
  `observacoes` text DEFAULT NULL,
  `data_cadastro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `categoria` enum('quimico','equipamento','acessorio','limpeza') NOT NULL,
  `unidade_medida` varchar(10) NOT NULL COMMENT 'kg, l, un, etc.',
  `preco_custo` decimal(10,2) NOT NULL,
  `preco_venda` decimal(10,2) NOT NULL,
  `estoque_atual` decimal(10,2) NOT NULL DEFAULT 0.00,
  `estoque_minimo` decimal(10,2) NOT NULL DEFAULT 1.00,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `data_cadastro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `categoria`, `unidade_medida`, `preco_custo`, `preco_venda`, `estoque_atual`, `estoque_minimo`, `ativo`, `data_cadastro`) VALUES
(1, 'Cloro Granulado', 'Cloro granulado estabilizado com 65% de cloro ativo', 'quimico', 'kg', 18.50, 30.00, 10.00, 5.00, 1, '2025-04-23 23:52:44'),
(2, 'Sulfato de Alumínio', 'Clarificante para águas turvas', 'quimico', 'kg', 12.30, 22.00, 8.00, 3.00, 1, '2025-04-23 23:52:44'),
(3, 'Elevador de pH', 'Produto para elevar o pH da água', 'quimico', 'kg', 15.40, 25.00, 5.00, 2.00, 1, '2025-04-23 23:52:44'),
(4, 'Redutor de pH', 'Produto para reduzir o pH da água', 'quimico', 'l', 17.80, 28.00, 6.00, 2.00, 1, '2025-04-23 23:52:44'),
(5, 'Algicida de Choque', 'Elimina rapidamente algas', 'quimico', 'l', 24.50, 45.00, 3.00, 1.00, 1, '2025-04-23 23:52:44'),
(6, 'Algicida de Manutenção', 'Previne o aparecimento de algas', 'quimico', 'l', 19.90, 35.00, 4.00, 2.00, 1, '2025-04-23 23:52:44'),
(7, 'Peneira para Folhas', 'Peneira com aro de plástico e tela', 'acessorio', 'un', 25.00, 40.00, 3.00, 1.00, 1, '2025-04-23 23:52:44'),
(8, 'Escova de Nylon', 'Para limpeza de paredes', 'limpeza', 'un', 22.00, 35.00, 4.00, 2.00, 1, '2025-04-23 23:52:44'),
(9, 'Aspirador Manual', 'Para limpeza do fundo da piscina', 'limpeza', 'un', 95.00, 150.00, 2.00, 1.00, 1, '2025-04-23 23:52:44'),
(10, 'Kit Teste pH e Cloro', 'Para medir níveis de pH e cloro', 'acessorio', 'un', 35.00, 55.00, 5.00, 2.00, 1, '2025-04-23 23:52:44');

-- --------------------------------------------------------

--
-- Estrutura para tabela `servicos`
--

CREATE TABLE `servicos` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `piscina_id` int(11) NOT NULL,
  `tipo_servico` enum('limpeza','tratamento','manutencao','instalacao','visita_tecnica') NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `data_agendamento` date NOT NULL,
  `hora_agendamento` time NOT NULL,
  `data_execucao` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fim` time DEFAULT NULL,
  `status` enum('agendado','em_andamento','concluido','cancelado') NOT NULL DEFAULT 'agendado',
  `valor_total` decimal(10,2) DEFAULT NULL,
  `forma_pagamento` enum('dinheiro','cartao_credito','cartao_debito','pix','transferencia','boleto') DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `tecnico_id` int(11) DEFAULT NULL,
  `data_cadastro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `nivel_acesso` enum('admin','tecnico','atendente') NOT NULL DEFAULT 'tecnico',
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `data_cadastro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `nivel_acesso`, `ativo`, `data_cadastro`) VALUES
(1, 'Administrador', 'admin@aquapool.com', '$2y$10$VT/46MWuUwFwa7rbHI7qY.vCKef63E35bG1iOyizMN7AaTMJpiqtu', 'admin', 1, '2025-04-23 23:52:44');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `analises`
--
ALTER TABLE `analises`
  ADD PRIMARY KEY (`id`),
  ADD KEY `piscina_id` (`piscina_id`),
  ADD KEY `servico_id` (`servico_id`),
  ADD KEY `tecnico_id` (`tecnico_id`);

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Índices de tabela `contrato_piscinas`
--
ALTER TABLE `contrato_piscinas`
  ADD PRIMARY KEY (`contrato_id`,`piscina_id`),
  ADD KEY `piscina_id` (`piscina_id`);

--
-- Índices de tabela `itens_servico`
--
ALTER TABLE `itens_servico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `servico_id` (`servico_id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices de tabela `movimentacao_estoque`
--
ALTER TABLE `movimentacao_estoque`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produto_id` (`produto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `piscinas`
--
ALTER TABLE `piscinas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `piscina_id` (`piscina_id`),
  ADD KEY `tecnico_id` (`tecnico_id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `analises`
--
ALTER TABLE `analises`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `itens_servico`
--
ALTER TABLE `itens_servico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `movimentacao_estoque`
--
ALTER TABLE `movimentacao_estoque`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `piscinas`
--
ALTER TABLE `piscinas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `analises`
--
ALTER TABLE `analises`
  ADD CONSTRAINT `analises_ibfk_1` FOREIGN KEY (`piscina_id`) REFERENCES `piscinas` (`id`),
  ADD CONSTRAINT `analises_ibfk_2` FOREIGN KEY (`servico_id`) REFERENCES `servicos` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `analises_ibfk_3` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`);

--
-- Restrições para tabelas `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `contratos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`);

--
-- Restrições para tabelas `contrato_piscinas`
--
ALTER TABLE `contrato_piscinas`
  ADD CONSTRAINT `contrato_piscinas_ibfk_1` FOREIGN KEY (`contrato_id`) REFERENCES `contratos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contrato_piscinas_ibfk_2` FOREIGN KEY (`piscina_id`) REFERENCES `piscinas` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `itens_servico`
--
ALTER TABLE `itens_servico`
  ADD CONSTRAINT `itens_servico_ibfk_1` FOREIGN KEY (`servico_id`) REFERENCES `servicos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `itens_servico_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`);

--
-- Restrições para tabelas `movimentacao_estoque`
--
ALTER TABLE `movimentacao_estoque`
  ADD CONSTRAINT `movimentacao_estoque_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`),
  ADD CONSTRAINT `movimentacao_estoque_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Restrições para tabelas `piscinas`
--
ALTER TABLE `piscinas`
  ADD CONSTRAINT `piscinas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `servicos`
--
ALTER TABLE `servicos`
  ADD CONSTRAINT `servicos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `servicos_ibfk_2` FOREIGN KEY (`piscina_id`) REFERENCES `piscinas` (`id`),
  ADD CONSTRAINT `servicos_ibfk_3` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
