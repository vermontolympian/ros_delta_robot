#include <Servo.h>

Servo myservo1;  // create servo object to control a servo
Servo myservo2;  // create servo object to control a servo
Servo myservo3;  // create servo object to control a servo

int pos1 = 0;    // variable to store the servo position
int pos2 = 0;    // variable to store the servo position
int pos3 = 0;    // variable to store the servo position
int off1 = 26;    // offset for servo1
int off2 = 5;    // offset for servo2
int off3 = 40;    // offset for servo3

int cycle = 40;
int rate = 20;

int moving = 1;

void setup() {
  myservo1.attach(9);  // attaches the servo on pin 9 to the servo object
  myservo2.attach(10);  // attaches the servo on pin 9 to the servo object
  myservo3.attach(11);  // attaches the servo on pin 9 to the servo object

  for (pos1 = 0; pos1 <= cycle; pos1 += 1) { // goes from 0 degrees to 180 degrees
    pos2 += 1;
    pos3 += 1;
    // in steps of 1 degree
    myservo1.write(pos1+off1);              // tell servo to go to position in variable 'pos'
    myservo2.write(pos2+off2);              // tell servo to go to position in variable 'pos'
    myservo3.write(pos3+off3);              // tell servo to go to position in variable 'pos'

    delay(rate);                       // waits 15ms for the servo to reach the position

    if (pos1 == cycle) {
      delay(400);
    }
  }
  
  for (pos1 = cycle; pos1 >= 0; pos1 -= 1) { // goes from 180 degrees to 0 degrees
    pos2 -= 1;
    pos3 -= 1;
    myservo1.write(pos1+off1);              // tell servo to go to position in variable 'pos'
    myservo2.write(pos2+off2);              // tell servo to go to position in variable 'pos'
    myservo3.write(pos3+off3);              // tell servo to go to position in variable 'pos'
    delay(rate);                       // waits 15ms for the servo to reach the position
    if (pos1 == 0) {
      delay(400);
    }
  }
}

void loop() {
  int goal1 = 60;
  int goal2 = 35;
  int goal3 = 22;
  while (moving == 1) {

    if (pos1 < goal1) {
      pos1 = pos1 + 1;
      myservo1.write(pos1+off1);
    }
    if (pos2 < goal2) {
      pos2 = pos2 + 1;
      myservo2.write(pos2+off2);
    }
    if (pos3 < goal3) {
    pos3 = pos3 + 1;
    myservo3.write(pos3+off3);
    }

    delay(20);
  }

    // Return to home //

  
}
