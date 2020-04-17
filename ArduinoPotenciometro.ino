int sensorValue;

int inputPin = A0;
int enviar;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  sensorValue = analogRead(inputPin);

  //Serial.println(sensorValue,DEC);

  //enviar = sensorValue;

  Serial.write(sensorValue/4);

  delay(100);
}
