To run the simulation
1. This assumes you have catkin installed. Source the ros environment
```
source /opt/ros/noetic/setup.bash
```
2. Create and build a catkin workspace:
```
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
```
3. Copy the delta_robot_support folder into the /src folder in the catkin workspace
4. Build the packages
```
catkin_make
```
5. Add the workspace to your ros environment.
```
. ~/catkin_ws/devel/setup.bash
```
6. Launch the simulation
```
roslaunch delta_robot_support delta_robot_sim.launch
```
7. In a seperate terminal, run the following command to control the joints. Replace 0,0,0 with the 3 joint angles that you want the robot to move to. The origin of the joint angles is 30   degrees above the horizon. The values sent in this command are in radians. 
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
