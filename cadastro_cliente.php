<?php
session_start();
if (!isset($_SESSION['email'])) {
    header('Location: ../index.php');
    exit();
}

include 'conexao.php';

$mensagem = ""; // Variável para armazenar mensagens de sucesso ou erro

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nome = filter_input(INPUT_POST, 'nome', FILTER_SANITIZE_STRING);
    $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);
    $telefone = filter_input(INPUT_POST, 'telefone', FILTER_SANITIZE_STRING);

    if (empty($nome) || empty($email) || empty($telefone)) {
        $mensagem = "<p style='color: red;'>Por favor, preencha todos os campos obrigatórios.</p>";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $mensagem = "<p style='color: red;'>Por favor, insira um email válido.</p>";
    } else {
        $sql = "INSERT INTO clientes (nome, email, telefone) VALUES (?, ?, ?)";
        $stmt = $conexao->prepare($sql);
        $stmt->bind_param("sss", $nome, $email, $telefone);

        if ($stmt->execute()) {
            header('Location: lista_agendamentos.php');
            exit();
        } else {
            $mensagem = "<p style='color: red;'>Erro ao cadastrar cliente: " . $stmt->error . "</p>";
        }

        $stmt->close();
    }

    $conexao->close();
}
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Cliente</title>
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
    </style>
</head>
<body>
    <a href="/barbearia/home.php" class="voltar-btn">Voltar</a>
    <div class="box">
        <form method="POST" action="">
            <fieldset>
                <legend><b>Cadastro de Cliente</b></legend>
                <br>
                <?php echo $mensagem; ?>
                <div class="inputBox">
                    <input type="text" name="nome" id="nome" class="inputUser" required>
                    <label for="nome" class="labelInput">Nome Completo</label>
                </div>
                <br><br>
                <div class="inputBox">
                    <input type="email" name="email" id="email" class="inputUser" required>
                    <label for="email" class="labelInput">Email</label>
                </div>
                <br><br>
                <div class="inputBox">
                    <input type="text" name="telefone" id="telefone" class="inputUser" required>
                    <label for="telefone" class="labelInput">Telefone</label>
                </div>
                <br><br>
                <input type="submit" value="Cadastrar">
            </fieldset>
        </form>
    </div>
</body>
</html>