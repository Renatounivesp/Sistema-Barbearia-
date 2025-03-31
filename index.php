<?php
session_start();
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
</head>
<body>
    <section class="container">
        <form action="valida_login.php" method="POST">
            <h1>Login Nova Era</h1>
            <div class="caixa-input">
                <input type="email" name="email" placeholder="Usuário" required>
                <i class='bx bx-user'></i>
            </div>
            <div class="caixa-input">
                <input type="password" name="senha" placeholder="Senha" required>
                <i class='bx bx-lock-alt'></i>
            </div>
            <div class="caixa-relembre">
                <label><input type="checkbox">Relembre-me</label>
                <a href="#">Esqueceu a senha?</a>
            </div>
            <br>
            <button type="submit" name="submit" class="botao">Login</button>
            <div class="caixa-registre">
                <p>Não possui uma conta? <a href="#">Registre-se</a></p>
            </div>
        </form>
    </section>
</body>
</html>
