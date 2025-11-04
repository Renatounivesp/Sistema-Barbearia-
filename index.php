<?php
session_start();

// Inclui o arquivo de acessibilidade
include_once 'includes/acessibilidade.php';
?>
 
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nova Era</title>
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
        <form action="valida_cliente.php" method="POST">
            <h1>
                <img src="/barbearia/img/logo.png" height="150" width="150"/>
            </h1>
            <div class="caixa-input">
                <input type="email" name="email" placeholder="Usuário" required>
            </div>
            <div class="caixa-input">
                <input type="password" name="senha" placeholder="Senha" required>
            </div>
            <div class="caixa-relembre">
                <label><input type="checkbox">Relembre-me</label>
                <a href="#">Esqueceu a senha?</a>
            </div>
            <br>
            <button type="submit" name="submit" class="botao">Login</button>
            <div class="caixa-registre">
                <p>Não possui uma conta? <a href="php/cadastro_cliente.php">Registre-se</a></p>
            </div>
        </form>
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