-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18-Mar-2022 às 02:28
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `devcond`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `areadisableddays`
--

CREATE TABLE `areadisableddays` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_area` int(11) NOT NULL,
  `day` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `areadisableddays`
--

INSERT INTO `areadisableddays` (`id`, `id_area`, `day`) VALUES
(1, 2, '2022-03-16');

-- --------------------------------------------------------

--
-- Estrutura da tabela `areas`
--

CREATE TABLE `areas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `allowed` int(11) NOT NULL DEFAULT 1,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `days` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `areas`
--

INSERT INTO `areas` (`id`, `allowed`, `title`, `cover`, `days`, `start_time`, `end_time`) VALUES
(1, 1, 'Academia', 'gyn.jpg', '1,2,4,5', '06:00:00', '22:00:00'),
(2, 1, 'Piscina', 'pool.jpg', '1,2,3,4,5', '07:00:00', '23:00:00'),
(3, 1, 'Churrasqueira', 'barbecue.jpg', '4,5,6', '09:00:00', '23:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `billets`
--

CREATE TABLE `billets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_unit` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileurl` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `billets`
--

INSERT INTO `billets` (`id`, `id_unit`, `title`, `fileurl`) VALUES
(1, 1, 'Dez/20', '1_dez20.pdf');

-- --------------------------------------------------------

--
-- Estrutura da tabela `docs`
--

CREATE TABLE `docs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileurl` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `docs`
--

INSERT INTO `docs` (`id`, `title`, `fileurl`) VALUES
(1, 'Regras do condomínio', 'manual.pdf'),
(2, 'Financeiro de Dezembro de 2020', 'fin_dez20.pdf');

-- --------------------------------------------------------

--
-- Estrutura da tabela `foundandlost`
--

CREATE TABLE `foundandlost` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'LOST',
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `where` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `foundandlost`
--

INSERT INTO `foundandlost` (`id`, `status`, `photo`, `description`, `where`, `datecreated`) VALUES
(1, 'recovered', 'alguma.jpg', 'Carteria azul cheia de dinheiro', 'No pátio', '2022-03-15'),
(2, 'RECOVERED', 'alguma2.jpg', 'Pente Verde', 'No Parquinho', '2022-03-15'),
(3, 'LOST', 'ODBkNPILf71e1xPlQBd74U9gPFxSyDy06pUmQ8s0.jpg', 'Foto de alguém', 'Na churrasqueira', '2022-03-15');

-- --------------------------------------------------------

--
-- Estrutura da tabela `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2022_03_10_190433_createalltables', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `reservations`
--

CREATE TABLE `reservations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `reservation_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `reservations`
--

INSERT INTO `reservations` (`id`, `id_unit`, `id_area`, `reservation_date`) VALUES
(1, 2, 2, '2022-03-17 08:00:00'),
(3, 2, 2, '2022-03-19 22:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `unitpeoples`
--

CREATE TABLE `unitpeoples` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_unit` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `unitpeoples`
--

INSERT INTO `unitpeoples` (`id`, `id_unit`, `name`, `birthdate`) VALUES
(1, 2, 'Paulo', '2000-03-15'),
(2, 2, 'Paula', '2000-03-15');

-- --------------------------------------------------------

--
-- Estrutura da tabela `unitpets`
--

CREATE TABLE `unitpets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_unit` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `race` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `unitpets`
--

INSERT INTO `unitpets` (`id`, `id_unit`, `name`, `race`) VALUES
(1, 2, 'Jadhy', 'Mestiça');

-- --------------------------------------------------------

--
-- Estrutura da tabela `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_owner` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `units`
--

INSERT INTO `units` (`id`, `name`, `id_owner`) VALUES
(1, 'APT 100', 1),
(2, 'APT 101', 1),
(3, 'APT 200', 0),
(4, 'APT 201', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `unitvehicles`
--

CREATE TABLE `unitvehicles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_unit` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `unitvehicles`
--

INSERT INTO `unitvehicles` (`id`, `id_unit`, `title`, `color`, `plate`) VALUES
(1, 2, 'Ferrari', 'Amarela', 'ZZZ-0908');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `cpf`, `password`) VALUES
(1, 'Carlos Alberto', 'carlos@hotmail.com', '12345612345', '$2y$10$8TiYRaaUl6T/PczjptZizuVY1dwmmKFvLKwD27m46zvvJjMMBTQpS'),
(2, 'Cicrano', 'cicrano@gmail.com', '25648971236', '$2y$10$zwtGWrIOdfUfbvLFlna1sOCyvxnB1EE09e392C/KWAuVN9fvQ6Umi');

-- --------------------------------------------------------

--
-- Estrutura da tabela `walllikes`
--

CREATE TABLE `walllikes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_wall` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `walllikes`
--

INSERT INTO `walllikes` (`id`, `id_wall`, `id_user`) VALUES
(1, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `walls`
--

CREATE TABLE `walls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datecreated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `walls`
--

INSERT INTO `walls` (`id`, `title`, `body`, `datecreated`) VALUES
(1, 'Título de Aviso de Teste', 'Lorem ipsum bkablablabvblalvblassd', '2020-12-20 15:00:00'),
(2, 'Alerta geral para TODOS', 'Bla bla bla cuidado bla bla bla', '2020-12-20 18:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `warnings`
--

CREATE TABLE `warnings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_unit` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'IN_REVIEW',
  `datecreated` date NOT NULL,
  `photos` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `warnings`
--

INSERT INTO `warnings` (`id`, `id_unit`, `title`, `status`, `datecreated`, `photos`) VALUES
(1, 2, 'Vizinho é chato', 'IN_REVIEW', '2022-03-14', 'foto1jpg,foto2.jpg'),
(2, 2, 'Vizinho chato2 via api', 'IN_REVIEW', '2022-03-15', ''),
(3, 2, 'Vizinho feio com foto', 'IN_REVIEW', '2022-03-15', 'mrID5GYRY60fTOPDBGgT8CHLeMDIvrLkM4It3hHS.jpg,mrID5GYRY60fTOPDBGgT8CHLeMDIvrLkM4It3hHS.jpg');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `areadisableddays`
--
ALTER TABLE `areadisableddays`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `billets`
--
ALTER TABLE `billets`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `docs`
--
ALTER TABLE `docs`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `foundandlost`
--
ALTER TABLE `foundandlost`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Índices para tabela `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `unitpeoples`
--
ALTER TABLE `unitpeoples`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `unitpets`
--
ALTER TABLE `unitpets`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `unitvehicles`
--
ALTER TABLE `unitvehicles`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_cpf_unique` (`cpf`);

--
-- Índices para tabela `walllikes`
--
ALTER TABLE `walllikes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `walls`
--
ALTER TABLE `walls`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `warnings`
--
ALTER TABLE `warnings`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `areadisableddays`
--
ALTER TABLE `areadisableddays`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `areas`
--
ALTER TABLE `areas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `billets`
--
ALTER TABLE `billets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `docs`
--
ALTER TABLE `docs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `foundandlost`
--
ALTER TABLE `foundandlost`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `unitpeoples`
--
ALTER TABLE `unitpeoples`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `unitpets`
--
ALTER TABLE `unitpets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `unitvehicles`
--
ALTER TABLE `unitvehicles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `walllikes`
--
ALTER TABLE `walllikes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `walls`
--
ALTER TABLE `walls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `warnings`
--
ALTER TABLE `warnings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
