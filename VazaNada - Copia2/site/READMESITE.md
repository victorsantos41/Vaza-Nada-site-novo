# VZND (VazaNada) - Sistema de Detecção de Vazamentos de Gás

## Descrição

O projeto **VZND (VazaNada)** visa desenvolver um sistema de monitoramento de vazamentos de gás em gasodutos, com a utilização de sensores de gás para detecção e uma aplicação web para visualização e alertas. O sistema ajudará a reduzir os riscos de acidentes e vazamentos em gasodutos, melhorando a segurança e diminuindo as perdas financeiras associadas.

<p align="center">
  <img src="https://i.postimg.cc/BZTd1G9n/Vz.png" alt="Descrição da Imagem" width="500"/>
</p>


## Objetivo

Entregar um sistema web integrado com sensores de gás em gasodutos para:
- Localizar vazamentos
- Mostrar alertas
- Exibir gráficos e estatísticas relevantes

## Justificativa

Com a instalação de sensores e a implementação do sistema, o objetivo é reduzir o tempo de detecção de vazamentos de gás em até 90%.

## Escopo

1. **Instalação dos Sensores**: Implementação de sensores em pontos estratégicos dos gasodutos.
2. **Desenvolvimento da API**: API para coleta de dados dos sensores e envio para o banco de dados.
3. **Desenvolvimento da Aplicação Web**: Site com dashboard para acompanhamento dos dados dos sensores.
4. **Banco de Dados**: MySQL para armazenamento e consulta dos dados coletados.
5. **Site Institucional**: Informações sobre a empresa e a solução.

## Para este projeto utilizaremos:
- **Front-End**: HTML, JavaScript
- **Banco de Dados**: MySQL
- **Hardware de prototipação**: Sensor MQ-2
- **Back-end**: NodeJS

## Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes tabelas:

### Tabela `Empresa`
Armazena informações das empresas cadastradas.

```sql
CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(150) NOT NULL,
nome VARCHAR(255) NOT NULL,
responsavel VARCHAR(80) NOT NULL,
telefone CHAR(11) NOT NULL
);
```

### Tabela `Unidade`
Armazena informações da unidade da empresa.

```sql
CREATE TABLE Unidade (
idUnidade INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
logradouro VARCHAR(100) NOT NULL,
numero VARCHAR(10) NOT NULL,
bairro VARCHAR(100) NOT NULL,
estado VARCHAR(100) NOT NULL,
cep CHAR(8) NOT NULL,
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaUnidade 
	FOREIGN KEY (fkEmpresa) 
		REFERENCES empresa (idEmpresa)
);
```

### Tabela `Setor`
Armazena informações dos setores onde os sensores estão instalados.

```sql
CREATE TABLE Setor (
idSetor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
descrição VARCHAR(100) NOT NULL,
fkUnidade INT NOT NULL,
CONSTRAINT fkSetorUnidade 
	FOREIGN KEY (fkUnidade) 
		REFERENCES empresa (idEmpresa)
);
```

### Tabela `Sensor`
Armazena informações dos sensores cadastradas.
```sql
CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
dtInstalação DATETIME NOT NULL,
dtÚltimaManutenção DATETIME NOT NULL,
fkSetor INT NOT NULL, 
CONSTRAINT fkSensorSetor 
	FOREIGN KEY (fkSetor) 
		REFERENCES Setor (idSetor)
);
```
### Tabela `Medição`
Armazena os registros de vazamentos.
```sql
CREATE TABLE Medição (
idMedição INT PRIMARY KEY AUTO_INCREMENT,
qtdGásVazado FLOAT NOT NULL,
dtComeçoVazamento DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
fkSensor INT NOT NULL, 
CONSTRAINT fkMediçãoSensor 
	FOREIGN KEY (fkSensor) 
		REFERENCES Sensor (idSensor)
);
```

### Tabela `Usuario`
Armazena os usuarios que poderam acessar a dashboard.
```sql
CREATE TABLE Usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
email VARCHAR(255) NOT NULL,
senha VARCHAR(255) NOT NULL,
fkEmpresa INT NOT NULL, 
CONSTRAINT fkUsuarioEmpresa 
	FOREIGN KEY (fkEmpresa) 
		REFERENCES Empresa (idEmpresa)
);
```

### Tabela `Login`
Armazena as informações de quem logou no sistema.
```sql
CREATE TABLE Login (
idLogin INT PRIMARY KEY AUTO_INCREMENT,
dtHrAcesso DATETIME,
dtHrSaída DATETIME,
fkUsuario INT,
CONSTRAINT fkLoginUsuario
	FOREIGN KEY (fkUsuario)
		REFERENCES Usuario (idUsuario)
);
```

## Simulador Financeiro

# Código de Exemplo
HTML e JavaScript para Calculadora de Economia
O código HTML e JavaScript abaixo permite estimar a economia com a solução VZND.


**HTML**
```html
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculadora VazaNada</title>
</head>
<body>
    <h1>Bem vindo!</h1>
    <h2>Preencha os campos abaixo para estimar sua economia utilizando a solução da VZND:</h2>
    <!-- Inputs para dados do usuário -->
    ...
    <button onclick="calcular()">Calcular</button>
    <br>
    <br>
    <div id="div_mensagem"></div>
</body>
</html>
```

**JavaScript**
```javascript
function calcular() {
    var qtdVazamentos = Number(ipt_qtdVazamentos.value);
    var maiorVazamento = Number(ipt_maiorVazamento.value);
    var menorVazamento = Number(ipt_menorVazamento.value);
    var maiorTempo = Number(ipt_maiorTempo.value) / 60; // Conversão de min para horas
    var menorTempo = Number(ipt_menorTempo.value) / 60; // Conversão de min para horas
    var custoGasMCubico = Number(ipt_custo_gas.value);

    if (qtdVazamentos == 0 || maiorVazamento == 0 || menorVazamento == 0 || maiorTempo == 0 || menorTempo == 0) {
        alert("Preencha todos os campos!");
    } else if (qtdVazamentos < 0 || maiorVazamento < 0 || menorVazamento < 0 || maiorTempo < 0 || menorTempo < 0) {
        alert("Os valores não podem ser negativos!");
    } else if (maiorVazamento < menorVazamento) {
        alert("O maior vazamento não pode ser menor que o menor vazamento!");
    } else if (maiorTempo < menorTempo) {
        alert("O menor tempo não pode ser maior que o maior tempo!");
    } else {
        var mediaQuantidadeVazadoPorHora = (maiorVazamento + menorVazamento) / 2;
        var mediaTempo = (maiorTempo + menorTempo) / 2;
        var mediaDePerdaPorVazamento = mediaQuantidadeVazadoPorHora * mediaTempo;
        var mediaDeCustoPorVazamento = mediaDePerdaPorVazamento * custoGasMCubico;
        var mediaAnual = mediaDePerdaPorVazamento * qtdVazamentos;
        var mediaMensal = mediaAnual / 12;
        var mediaCustoAnual = mediaDeCustoPorVazamento * qtdVazamentos;
        var mediaCustoMensal = mediaCustoAnual / 12;

        var mediaTempoDesconto = mediaTempo * 0.1;
        var mediaDePerdaPorVazamentoDesconto = mediaQuantidadeVazadoPorHora * mediaTempoDesconto;
        var mediaCustoPorVazamentoDesconto = mediaDePerdaPorVazamentoDesconto * custoGasMCubico;
        var mediaCustoAnualDesconto = mediaCustoPorVazamentoDesconto * qtdVazamentos;
        var mediaCustoMensalDesconto = mediaCustoAnualDesconto / 12;

        div_mensagem.innerHTML = `
            <b>Você perdeu aproximadamente:</b> 
            <ul>
                <li>💸 ${mediaCustoAnual.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })} nos últimos 12 meses.</li>
                <li>📅 Uma média mensal de ${mediaCustoMensal.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })}</li>
                <li>🔄 Perdendo aproximadamente ${mediaAnual.toLocaleString()} m³ de gás por ano</li>
                <li>📉 Perdendo aproximadamente ${mediaMensal.toLocaleString()} m³ de gás por mês</li>
            </ul>
            
            <b>Com a solução da VZ<span style="color: #5CE1E6">ND</span>, você poderia:</b>`
    }
}
            
```


## Prototipação com Arduino e Sensor MQ-2

### Visão Geral

Este projeto utiliza um Arduino e um sensor de gás MQ-2 para prototipação de sistemas de monitoramento em gasodutos. O sensor MQ-2 é projetado para detectar gases como metano, propano, monóxido de carbono e fumaça, tornando-o útil para várias aplicações de monitoramento de gás.

### Componentes Utilizados

- **Arduino Uno**: Placa de prototipagem baseada em microcontrolador, amplamente utilizada para desenvolver e testar projetos eletrônicos.
- **Sensor MQ-2**: Sensor de gás capaz de detectar diferentes tipos de gases e fumaça. Ideal para a medição da qualidade do ar.

### Objetivo

A prototipação com o Arduino e o sensor MQ-2 visa criar um sistema inicial para monitoramento e análise de gás. Este sistema permitirá a leitura dos níveis de gases no ambiente e a visualização dessas informações, proporcionando uma base para o desenvolvimento da aplicação.

### Como Funciona

1. **Conexão do Hardware**: O sensor MQ-2 é conectado à placa Arduino. Os pinos do sensor são conectados às entradas analógicas e digitais do Arduino para leitura dos dados de gás.
2. **Programação do Arduino**: O Arduino é programado para ler os valores do sensor MQ-2, processar esses dados e, em seguida, exibir essas imagens em um gráfico através do arduino IDE.
3. **Testes e Validação**: Durante a fase de prototipação, o sistema é testado em diferentes condições para validar a precisão e a resposta do sensor MQ-2.

### Código de Exemplo

Aqui está um exemplo básico de código para começar a prototipação:

```cpp
const int PINO_SENSOR_MQ2 = A0; // Variavel da porta analógica

// Parâmetros utilizados para o calculo da Porcentagem de gas 
const int VALOR_MINIMO = 100; 
const int VALOR_MAXIMO = 1000;

void setup() { // executa apenas uma vez assim que o código é enviado para o arduino
   
 Serial.begin(9600);  // Frequência de transmissão entre o arduino e a IDE (frequência de transmissão de bits enviados por segundo)
}

void loop() { // executa infinitas vezes 
  int valorSensor = analogRead(PINO_SENSOR_MQ2); // leitura da porta analógica

  float porcentagem = ((float) (valorSensor - VALOR_MINIMO) / (VALOR_MAXIMO - VALOR_MINIMO)) * 100; // calculo da porcentagem de gás
  
  if (porcentagem < 0) {
    porcentagem = 0; 

  } else if (porcentagem > 100) {
    porcentagem = 100;
  }

  Serial.print("Porcentagem:"); // legenda do gráfico
  Serial.print(porcentagem); // valor 
  Serial.print(" ");
  
  Serial.print("VolumeMínimo:");
  Serial.print(1);
  Serial.print(" ");
  
  Serial.print("VolumeCritico:");
  Serial.println(20);
  delay(1000); // valor em milisegundos

}  
```

