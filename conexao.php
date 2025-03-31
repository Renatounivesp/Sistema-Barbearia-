<?php
$servidor = "localhost";
$usuario = "root";
$senha = ""; // ajuste se necessário
$banco = "barbearia";

$conexao = new mysqli($servidor, $usuario, $senha, $banco);

if ($conexao->connect_error) {
    die("Erro na conexão: " . $conexao->connect_error);
}
?>
