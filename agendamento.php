<?php
session_start();
if (!isset($_SESSION['email'])) {
    header('Location: ../index.php');
    exit();
}

include 'conexao.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $cliente_id = $_POST['cliente_id'];
    $data = $_POST['data'];
    $hora = $_POST['hora'];
    $servico = $_POST['servico'];

    $sql = "INSERT INTO agendamentos (cliente_id, data, hora, servico)
            VALUES ('$cliente_id', '$data', '$hora', '$servico')";

    if ($conexao->query($sql) === TRUE) {
        header('Location: lista_agendamentos.php');
        exit();
    } else {
        echo "<p style='color: red;'>Erro ao agendar: " . $conexao->error . "</p>";
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

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agendar Horário</title>
    <style>
        /* Estilos gerais do corpo da página */
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #1a1a1a; /* Tom de preto um pouco mais claro para o fundo */
            color: #fff; /* Cor do texto padrão como branco */
            margin: 0; /* Remove as margens padrão do body */
            padding: 20px; /* Adiciona padding para o botão não ficar colado na borda */
            display: flex; /* Usa flexbox para alinhar os elementos */
            flex-direction: column; /* Alinha os itens verticalmente */
            align-items: center; /* Centraliza os itens horizontalmente */
            min-height: 100vh; /* Garante que o body ocupe pelo menos a altura da tela */
            position: relative; /* Necessário para posicionar o botão voltar */
        }

        /* Estilo do botão voltar */
        .voltar-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: #000;
            color: #fff;
            border: 1px solid #fff;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .voltar-btn:hover {
            background-color: #333;
        }

        /* Estilo do título principal */
        h2 {
            color: #e72020; /* Tom de vermelho para o título */
            margin-top: 60px; /* Aumenta a margem para não sobrepor o botão */
            margin-bottom: 20px; /* Espaçamento inferior */
        }

        /* Estilo da caixa principal dos formulários */
        .box {
            background-color: rgba(50, 50, 50, 0.8); /* Fundo cinza escuro transparente */
            border-radius: 15px; /* Bordas arredondadas */
            padding: 20px; /* Preenchimento interno */
            width: 40%; /* Largura da caixa */
            max-width: 500px; /* Largura máxima para não ficar muito grande em telas maiores */
            margin-bottom: 20px; /* Espaçamento inferior */
        }

        /* Estilo do fieldset (agrupamento de campos) */
        fieldset {
            border: 2px solid #faf8f8; /* Borda branca */
            padding: 20px; /* Preenchimento interno */
            border-radius: 8px; /* Bordas arredondadas */
        }

        /* Estilo da legenda do fieldset (título do grupo) */
        legend {
            font-size: 1.5em; /* Tamanho da fonte */
            font-weight: bold; /* Texto em negrito */
            color: #0e6fee; /* Cor do texto */
            padding: 10px; /* Preenchimento interno */
            border-radius: 5px; /* Bordas arredondadas */
            border: 1px solid #0e66e9; /* Borda */
            background-color: #333; /* Fundo cinza mais escuro */
        }

        /* Estilo da div que envolve o input e o label */
        .inputBox {
            position: relative; /* Necessário para posicionar o label */
            margin-bottom: 20px; /* Espaçamento inferior entre os campos */
        }

        /* Estilo dos campos de input (texto, email, telefone) */
        .inputUser {
            background: none; /* Fundo transparente */
            border: none; /* Remove a borda padrão */
            border-bottom: 1px solid #fff; /* Adiciona uma borda inferior branca */
            outline: none; /* Remove a borda de foco */
            color: #fff; /* Cor do texto digitado */
            font-size: 15px; /* Tamanho da fonte */
            width: 100%; /* Largura total do container */
            padding: 10px 0; /* Preenchimento superior e inferior */
            letter-spacing: 1px; /* Espaçamento entre as letras */
        }

        /* Estilo da label dos inputs */
        .labelInput {
            position: absolute; /* Posiciona a label em relação ao inputBox */
            top: 0px; /* Inicialmente no topo do input */
            left: 0px; /* Alinhada à esquerda do input */
            pointer-events: none; /* Permite que o clique passe pela label para o input */
            transition: .5s; /* Transição suave para a animação */
        }

        /* Estilo da label quando o input está em foco ou tem algum valor */
        .inputUser:focus ~ .labelInput,
        .inputUser:valid ~ .labelInput {
            top: -20px; /* Move a label para cima */
            font-size: 12px; /* Diminui o tamanho da fonte */
            color: #e72020; /* Muda a cor da label */
        }

        /* Estilo do input de data */
        input[type="date"],
        input[type="time"] {
            border: 1px solid #fff; /* Borda branca */
            padding: 10px; /* Preenchimento interno */
            border-radius: 5px; /* Bordas arredondadas */
            outline: none; /* Remove a borda de foco */
            font-size: 16px; /* Tamanho da fonte */
            color: #333; /* Cor do texto */
            background-color: #fff; /* Fundo branco */
            width: calc(100% - 22px); /* Ajuste para o padding e borda */
        }

        /* Estilo do botão de submit */
        input[type="submit"] {
            background-color: #e72020; /* Fundo vermelho */
            color: #fff; /* Texto branco */
            border: none; /* Remove a borda */
            padding: 15px 20px; /* Preenchimento interno */
            font-size: 16px; /* Tamanho da fonte */
            cursor: pointer; /* Muda o cursor para indicar que é clicável */
            border-radius: 5px; /* Bordas arredondadas */
            width: 100%; /* Largura total do container */
            transition: background-color 0.3s ease; /* Transição suave para o hover */
        }

        /* Estilo do botão de submit quando o mouse passa por cima */
        input[type="submit"]:hover {
            background-color: #b81818; /* Tom de vermelho mais escuro no hover */
        }

        /* Estilo para o select (ID do Cliente) */
        .inputBox select.inputUser {
            padding: 10px 0;
            appearance: none; /* Remove a aparência padrão do select */
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="#fff" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position-x: 100%;
            background-position-y: 5px;
        }

        /* Estilo da label do select */
        .labelInputSelect {
            position: absolute;
            top: 0px;
            left: 0px;
            pointer-events: none;
            transition: .5s;
            color: #fff; /* Cor inicial da label do select */
        }

        /* Estilo da label do select quando o select tem um valor selecionado */
        .inputBox select.inputUser:valid ~ .labelInputSelect,
        .inputBox select.inputUser:focus ~ .labelInputSelect {
            top: -20px;
            font-size: 12px;
            color: #e72020;
        }
    </style>
</head>
<body>
    <a href="lista_agendamentos.php" class="voltar-btn">Voltar</a>
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
                    <input type="date" name="data" id="data" class="inputUser" required>
                    <label for="data" class="labelInput">Data</label>
                </div>
                <br><br>
                <div class="inputBox">
                    <input type="time" name="hora" id="hora" class="inputUser" required>
                    <label for="hora" class="labelInput">Hora</label>
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
</body>
</html>