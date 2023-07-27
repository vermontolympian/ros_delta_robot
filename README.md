To run the simulation
1. Add the files to the source folder of a catkin workspace. 
  Note: This project was developed using ros noetic.
2. Build the packages
```
catkin_make
```
3. Launch the simulation
```
roslaunch delta_robot_support delta_robot_sim.launch
```
4. In a seperate terminal, run the following command to control the joints. Replace 0,0,0 with the 3 joint angles that you want the robot to move to. The origin of the joint angles is 30   degrees above the horizon. The values sent in this command are in radians. 
```
rostopic pub -1 /arms_joint_state_controller/command std_msgs/Float64MultiArray "{data:[0,0,0],layout: {dim:[], data_offset: 1"}}
```




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
