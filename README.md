In order to use roserial
https://www.clearpathrobotics.com/assets/guides/noetic/ros/Driving%20Husky%20with%20ROSSerial.html
1. Install ardiuno ide to linux
```
snap install ardiuno
```
Follow direction to set up all the ports
2. Install rosserial
```
sudo apt-get install arduino arduino-core ros-noetic-rosserial ros-noetic-rosserial-arduino
```
3. add test ardiuno libraries
```
cd ~/snap/ardiuno/85/Ardiuno/libraries/
rosrun rosserial_arduino make_libraries.py .
```
4. launch rosnode for ardiuno
```
rosrun rosserial_python serial_node.py _port:=/dev/ttyACM0
```
