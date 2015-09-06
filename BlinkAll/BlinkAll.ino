/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.
 
  This example code is in the public domain.
 */
 
// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
int led_on = 13;
int led_off = 7;

// the setup routine runs once when you press reset:
void setup() {                
  int i;
  // initialize the digital pin as an output.
  for (i = 2; i < 14; i++)
      pinMode(i, OUTPUT);     
}

// the loop routine runs over and over again forever:
void loop() {
  digitalWrite(led_on++, HIGH);   // turn the LED on (HIGH is the voltage level)
  if (led_on > 13)
    led_on = 2;
  delay(100);               // wait for a second
  digitalWrite(led_off++, LOW);    // turn the LED off by making the voltage LOW
  if (led_off > 13)
    led_off = 2;
  delay(100);               // wait for a second
}
