<?php
session_start();
if (!isset($_SESSION['email'])) {
    header('Location: ../index.php');
    exit();
}

include 'conexao.php';

if (!isset($_GET['id'])) {
    echo "ID de agendamento não especificado.";
    exit();
}

$id = $_GET['id'];

$sql = "DELETE FROM agendamentos WHERE id = $id";

if ($conexao->query($sql) === TRUE) {
    header('Location: lista_agendamentos.php');
    exit();
} else {
    echo "Erro ao excluir: " . $conexao->error;
}
?>
