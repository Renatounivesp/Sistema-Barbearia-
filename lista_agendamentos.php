<?php
session_start();
if (!isset($_SESSION['email'])) {
    header('Location: ../index.php');
    exit();
}

include 'conexao.php';

$sql = "SELECT a.id, c.nome AS cliente, a.data, a.hora, a.servico
        FROM agendamentos a
        JOIN clientes c ON a.cliente_id = c.id";
$result = $conexao->query($sql);

$erro_sql = "";
if (!$result) {
    $erro_sql = "Erro na consulta SQL: " . $conexao->error;
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Agendamentos</title>
    <style>
        /* Estilos gerais do corpo da página */
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #1a1a1a;
            color: #fff;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        h2 {
            color: #e72020;
            margin-top: 30px;
            margin-bottom: 20px;
        }

        table {
            width: 80%;
            max-width: 900px;
            border-collapse: collapse;
            margin-bottom: 20px;
            background-color: rgba(50, 50, 50, 0.8);
            border-radius: 8px;
            overflow: hidden;
        }

        th {
            background-color: #333;
            color: #fff;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #555;
        }

        tbody tr:nth-child(even) {
            background-color: rgba(60, 60, 60, 0.7);
        }

        td a {
            color: #0e6fee;
            text-decoration: none;
            margin-right: 10px;
            transition: color 0.3s ease;
        }

        td a:hover {
            color: #e72020;
        }

        .erro-sql {
            color: red;
            margin-bottom: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<a href="/barbearia/home.php" class="voltar-btn">Voltar</a>
    <h2>Agendamentos</h2>

    <?php if (!empty($erro_sql)): ?>
        <p class="erro-sql"><?php echo $erro_sql; ?></p>
    <?php else: ?>
        <table>
            <thead>
                <tr>
                    <th>Cliente</th>
                    <th>Data</th>
                    <th>Hora</th>
                    <th>Serviço</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($row['cliente']); ?></td>
                        <td><?php echo htmlspecialchars($row['data']); ?></td>
                        <td><?php echo htmlspecialchars($row['hora']); ?></td>
                        <td><?php echo htmlspecialchars($row['servico']); ?></td>
                        <td>
                            <a href="editar_agendamento.php?id=<?php echo $row['id']; ?>">Editar</a> |
                            <a href="excluir_agendamento.php?id=<?php echo $row['id']; ?>" onclick="return confirm('Tem certeza que deseja excluir?')">Excluir</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    <?php endif; ?>

</body>
</html>