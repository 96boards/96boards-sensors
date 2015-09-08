/*
  BlinkAll
  Flash LEDs connected to all the IO lines, and generate some traffic on the UART
 
  This example code is in the public domain.
 */
 
int led_on = 13;
int led_off = 7;
char message[] = "Received character ' '";

// the setup routine runs once when you press reset:
void setup() {
  int i;
  // initialize the digital pins as outputs.
  for (i = 2; i <= A6; i++)
      pinMode(i, OUTPUT);
   Serial.begin(9600);
   Serial.println("Press a key, and I will echo it back");
}

// the loop routine runs over and over again forever:
void loop() {
  if (Serial.available()) {
    message[20] = Serial.read();
    Serial.println(message);
  }
  digitalWrite(led_on++, HIGH);   // turn the LED on (HIGH is the voltage level)
  if (led_on > A6)
    led_on = 2;
  delay(50);
  digitalWrite(led_off++, LOW);    // turn the LED off by making the voltage LOW
  if (led_off > A6)
    led_off = 2;
  delay(50);
}
