<?php

session_start();
if (!isset($_SESSION['email'])) {
    header('Location: ../index.php');
    exit();
}

include './php/conexao.php';

function buscarHorariosOcupados($conexao, $data) {
    $horariosOcupados = [];
    $sql = "SELECT hora FROM agendamentos WHERE data = '$data'";
    $result = $conexao->query($sql);

    if ($result && $result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $horariosOcupados[] = $row['hora'];
        }
    }
    return $horariosOcupados;
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $cliente_id = $_POST['cliente_id'];
    $datetime = $_POST['datetimepicker'];
    $servico = $_POST['servico'];

    list($data, $hora) = explode(' ', $datetime);

    $horarios_ocupados = buscarHorariosOcupados($conexao, $data);

    echo "<pre>Horários Ocupados:</pre>";
    var_dump($horarios_ocupados);
    echo "<pre>Hora Selecionada: " . htmlspecialchars($hora) . "</pre>";

    if (in_array($hora, $horarios_ocupados)) {
        echo "<p style='color: red;'>Este horário já está ocupado para a data selecionada. Por favor, escolha outro horário.</p>";
    } else {
        $sql = "INSERT INTO agendamentos (cliente_id, data, hora, servico)
                    VALUES ('$cliente_id', '$data', '$hora', '$servico')";

        if ($conexao->query($sql) === TRUE) {
            header('Location: lista_agendamentos.php');
            exit();
        } else {
            echo "<p style='color: red;'>Erro ao agendar: " . $conexao->error . "</p>";
        }
    }
}

// Buscar clientes para o select
$sql_clientes = "SELECT id, nome FROM clientes";
$result_clientes = $conexao->query($sql_clientes);
$clientes = [];
if ($result_clientes->num_rows > 0) {
    while ($row = $result_clientes->fetch_assoc()) {
        $clientes[$row['id']] = $row['nome'];
    }
}

$conexao->close();
?>
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agendar Horário</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
   
</head>
<body>
    <a href="#" class="voltar-btn">Voltar</a>
    <div class="box">
        <form method="POST" action="">
            <fieldset>
                <legend><b>Agendar Horário</b></legend>
                <br>
                <div class="inputBox">
                    <select name="cliente_id" id="cliente_id" class="inputUser" required>
                        <option value="">Selecione o Cliente</option>
                        <?php foreach ($clientes as $id => $nome): ?>
                            <option value="<?php echo $id; ?>"><?php echo htmlspecialchars($nome); ?></option>
                        <?php endforeach; ?>
                    </select>
                    <label for="cliente_id" class="labelInputSelect">ID do Cliente</label>
                </div>
                <br>
                <div class="inputBox">
                    <input type="text" name="datetimepicker" id="datetimepicker" class="inputUser" required>
                    <label for="datetimepicker" class="labelInput">Data e Hora</label>
                </div>
                <br><br>
                <div class="inputBox">
                    <input type="text" name="servico" id="servico" class="inputUser" required>
                    <label for="servico" class="labelInput">Serviço</label>
                </div>
                <br><br>
                <input type="submit" value="Agendar">
            </fieldset>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        flatpickr("#datetimepicker", {
          enableTime: true,
          dateFormat: "Y-m-d H:i", // Formato de data e hora para o banco de dados
          time_24hr: true,
        });
      });
    </script>
</body>
</html>