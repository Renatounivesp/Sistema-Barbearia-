<?php
session_start();
if (!isset($_SESSION['email'])) {
    header('Location: index.php');
    exit();
}

// Inclui o arquivo de acessibilidade (passo 4)
include_once 'includes/acessibilidade.php';
?>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>Bem-vindo</title>
    <link rel="stylesheet" href="estilo.css">
    <link rel="icon" href="img/icon1.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        /* Estilo dos botões de acessibilidade */
        .acessibilidade {
            position: fixed;
            top: 10px;
            right: 10px;
            z-index: 1000;
        }

        .acessibilidade button {
            background-color: #007BFF;
            border: none;
            color: white;
            font-size: 18px;
            padding: 5px 10px;
            margin: 2px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .acessibilidade button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <!-- Botões de acessibilidade -->
    <div class="acessibilidade">
        <button onclick="ajustarFonte(1)">A+</button>
        <button onclick="ajustarFonte(-1)">A-</button>
    </div>

    <section class="container">
        <h1>Olá, <?php echo $_SESSION['nome_cliente']; ?>!</h1>
        <div class="botoes-home">
            <a href="php/agendamentoCliente.php" class="botao">Agendar</a>
            <a href="php/lista_agendamentos.php" class="botao">Ver Agendamentos</a>
            <a href="logout.php" class="botao botao-sair">Sair</a>
        </div>
    </section>

    <script>
        // Função de acessibilidade: aumentar/diminuir tamanho da fonte
        function ajustarFonte(delta) {
            const body = document.body;
            const estilo = window.getComputedStyle(body, null).getPropertyValue('font-size');
            const tamanhoAtual = parseFloat(estilo);
            body.style.fontSize = (tamanhoAtual + delta) + 'px';
        }
    </script>

</body>
</html>