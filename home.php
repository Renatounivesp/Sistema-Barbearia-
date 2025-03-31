<?php
session_start();
if (!isset($_SESSION['email'])) {
    header('Location: index.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>Bem-vindo</title>
    <link rel="stylesheet" href="estilo.css">
    <link rel="icon" href="img/icon1.png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <section class="container">
        <h1>Olá, <?php echo $_SESSION['email']; ?>!</h1>
        <div class="botoes-home">
            <a href="php/cadastro_cliente.php" class="botao">Cadastrar Cliente</a>
            <a href="php/agendamento.php" class="botao">Criar Agendamento</a>
            <a href="php/lista_agendamentos.php" class="botao">Ver Agendamentos</a>
            <a href="logout.php" class="botao botao-sair">Sair</a>
        </div>
    </section>
</body>
</html>
