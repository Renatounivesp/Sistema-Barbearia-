<?php
session_start();
include_once('php/conexao.php');

if (isset($_POST['submit']) && !empty($_POST['email']) && !empty($_POST['senha'])) {
    $email = $_POST['email'];
    $senha = $_POST['senha'];

    $sql = "SELECT * FROM usuarios WHERE email = '$email' AND senha = '$senha'";
    $result = $conexao->query($sql);

    if ($result && $result->num_rows > 0) {
        $_SESSION['email'] = $email;
        header('Location: home.php');
        exit();
    } else {
        echo "<p>Login inválido. <a href='index.php'>Tentar novamente</a></p>";
    }
} else {
    header('Location: index.php');
    exit();
}
