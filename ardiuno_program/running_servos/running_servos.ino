#include <ros.h>
#include <std_msgs/Float64MultiArray.h>
#include <std_msgs/Bool.h>
#include <Servo.h>

//used for holding the angle that is desired
float angle_value[3];
ros::NodeHandle node_handle;

std_msgs::Float64MultiArray array_msg;
std_msgs::Bool movement_complete;

//Variables for the moving the servos
Servo myservo1;  // create servo object to control a servo
Servo myservo2;  // create servo object to control a servo
Servo myservo3;  // create servo object to control a servo

int pos1 = 0;    // variable to store the servo position
int pos2 = 0;    // variable to store the servo position
int pos3 = 0;    // variable to store the servo position
int off1 = 0;    // offset for servo1
int off2 = 20;    // offset for servo2
int off3 = 30;    // offset for servo3

int cycle = 40;
int rate = 20; //ms delay between moves

//sending movemnt =ment complete msg timing
long int start_time=0;
int delay_time=100; //ms

void subscriberCallback(const std_msgs::Float64MultiArray& array_msg) {

  angle_value[0]=array_msg.data[0];
  angle_value[1]=array_msg.data[1];
  angle_value[2]=array_msg.data[2];
  
//  for(int i =0; i<3;i++){
//    char result[8]; // Buffer big enough for 7-character float
//    dtostrf(angle_value[i], 6, 2, result); // Leave room for too large numbers!
//    node_handle.loginfo(result);
//  }
}

int calc_step_angle(int current_pos, float desired){
  if(int(desired) < current_pos){
    current_pos -=1;
  }
  else if (int(desired) > current_pos){
    current_pos +=1;
  }
  else{
    current_pos=int(desired);
  }
  char result[8]; // Buffer big enough for 7-character float
  dtostrf(current_pos, 6, 2, result); // Leave room for too large numbers!
  node_handle.loginfo(result);
  return current_pos;
}

ros::Publisher is_complete_publisher("real_bot_mov_com", &movement_complete);
ros::Subscriber<std_msgs::Float64MultiArray> array_sub("array_test", &subscriberCallback);

void setup()
{
  node_handle.initNode();
  node_handle.advertise(is_complete_publisher);
  node_handle.subscribe(array_sub);

  myservo1.attach(9);  // attaches the servo on pin 9 to the servo object
  myservo2.attach(10);  // attaches the servo on pin 9 to the servo object
  myservo3.attach(11);  // attaches the servo on pin 9 to the servo object

  angle_value[0]=0; //default angle value on start up
  angle_value[1]=0; //default angle value on start up
  angle_value[2]=0; //default angle value on start up
}

void loop()
{ 
  node_handle.spinOnce();
  
  pos1=calc_step_angle(pos1,angle_value[0]);
  pos2=calc_step_angle(pos2,angle_value[1]);
  pos3=calc_step_angle(pos3,angle_value[2]);
  // in steps of 1 degree
  myservo1.write(pos1);              // tell servo to go to position in variable 'pos'
  myservo2.write(pos2);              // tell servo to go to position in variable 'pos'
  myservo3.write(pos3);              // tell servo to go to position in variable 'pos'

  delay(rate);

  if (pos1 == angle_value[0] and pos2 == angle_value[1] and pos3 == angle_value[2] ) {
    movement_complete.data=true;
    is_complete_publisher.publish( &movement_complete );
  }
  else{
    if(millis() > start_time+delay_time){
      movement_complete.data=false;
      is_complete_publisher.publish( &movement_complete );
    }
    
  }
  delay(100);
}
