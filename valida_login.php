<?php
session_start();
include_once('includes/conexao.php'); // espera $conn (mysqli)

// Apenas via POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: master.php');
    exit;
}

$email = filter_var(trim($_POST['email'] ?? ''), FILTER_VALIDATE_EMAIL);
$senha = trim($_POST['senha'] ?? '');

if (!$email || $senha === '') {
    $_SESSION['login_error'] = 'Email e senha são obrigatórios.';
    header('Location: master.php');
    exit;
}

// Busca usuário (use senhas armazenadas com password_hash)
$sql = "SELECT id, nome, senha, tipo FROM usuarios WHERE email = ? AND tipo = 'master' LIMIT 1";
if ($stmt = mysqli_prepare($conn, $sql)) {
    mysqli_stmt_bind_param($stmt, 's', $email);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if ($user = mysqli_fetch_assoc($result)) {
        // Verifica senha (assume hash com password_hash)
        if (password_verify($senha, $user['senha'])) {
            session_regenerate_id(true);
            $_SESSION['usuario_id']   = $user['id'];
            $_SESSION['usuario_nome'] = $user['nome'];
            $_SESSION['usuario_tipo'] = $user['tipo'];
            mysqli_stmt_close($stmt);
            header('Location: dashboard_master.php');
            exit;
        }
    }
    mysqli_stmt_close($stmt);
}

// Falha no login
$_SESSION['login_error'] = 'Usuário ou senha inválidos.';
header('Location: master.php');
exit;
?>