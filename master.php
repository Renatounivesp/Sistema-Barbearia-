<?php 
session_start();
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Master - Nova Era</title>
    <link rel="stylesheet" href="estilo.css">
    <link rel="icon" href="img/icon1.png">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #003366, #0055a5);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            background: #ffffff;
            border-radius: 20px;
            padding: 40px;
            width: 350px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .container img {
            margin-bottom: 15px;
        }

        h1 {
            color: #003366;
            font-size: 22px;
            margin-bottom: 25px;
        }

        .caixa-input {
            position: relative;
            margin-bottom: 20px;
        }

        .caixa-input input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 10px;
            outline: none;
            font-size: 14px;
        }

        .caixa-input input:focus {
            border-color: #007bff;
        }

        .caixa-relembre {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: #333;
        }

        .caixa-relembre a {
            color: #0055a5;
            text-decoration: none;
        }

        .caixa-relembre a:hover {
            text-decoration: underline;
        }

        .botao {
            background: #0055a5;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .botao:hover {
            background: #003d7a;
        }

        .caixa-registre {
            margin-top: 15px;
            font-size: 14px;
        }

        .caixa-registre a {
            color: #0055a5;
            font-weight: bold;
            text-decoration: none;
        }

        .caixa-registre a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <section class="container">
        <form action="valida_login.php" method="POST">
            <img src="img/logo.png" alt="Logo Nova Era" width="120">
            <h1>Acesso Master</h1>

            <div class="caixa-input">
                <input type="email" name="email" placeholder="Usuário (e-mail)" required>
            </div>

            <div class="caixa-input">
                <input type="password" name="senha" placeholder="Senha" required>
            </div>

            <div class="caixa-relembre">
                <label><input type="checkbox"> Relembre-me</label>
                <a href="#">Esqueceu a senha?</a>
            </div>

            <button type="submit" name="submit" class="botao">Entrar</button>

            <div class="caixa-registre">
                <p>Não possui conta? <a href="#">Solicite acesso</a></p>
            </div>
        </form>
    </section>
</body>
</html>