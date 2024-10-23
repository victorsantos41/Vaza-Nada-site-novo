// Sensor oficial sem Labels para não dar erro com o MySQL que não adiciona string, apenas números
 
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

  Serial.println(porcentagem); // valor 
  
  delay(1000); // valor em milisegundos

}