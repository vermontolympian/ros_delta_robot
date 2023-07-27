#!/usr/bin/env python
# Software License Agreement (BSD License)
#
# Copyright (c) 2008, Willow Garage, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#  * Neither the name of Willow Garage, Inc. nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# Revision $Id$

## Simple talker demo that published std_msgs/Strings messages
## to the 'chatter' topic

import rospy
import numpy as np
import math
from std_msgs.msg import Float64MultiArray, String
from sensor_msgs.msg import JointState

current_angle = [0,0,0]
goal_angle = [0,0,0]
number_of_interpolation_steps = 100
delay_between_interpolation_steps = 0.1

pub = rospy.Publisher('/arms_joint_state_controller/command', Float64MultiArray, queue_size=10)

def goal_pose_callback(data):
    global goal_angle
    goal_angle = [data.data[0]*2,data.data[1]*2,data.data[2]*2]
    my_msg = Float64MultiArray()  
    my_msg.data = [data.data[0]*2,data.data[1]*2,data.data[2]*2]
    pub.publish(my_msg)


def current_pose_callback(data):
    global current_angle
    current_angle = [180/math.pi*data.position[0],180/math.pi*data.position[1],180/math.pi*data.position[2]]


def talker():
    rospy.init_node('talker', anonymous=True)
    rospy.Subscriber("/goal_position", Float64MultiArray, goal_pose_callback)
    rospy.Subscriber("/joint_states", JointState, current_pose_callback)
    rospy.spin()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass

def calc_yz(x,y,z,upper,lower,Rf,Rm):
  y1 = -Rf
  y -= Rm
  a = (x*x + y*y + z*z + upper*upper - lower*lower - y1*y1)/(2*z)
  b = (y1-y)/z
  d = -(a + b*y1)*(a + b*y1) + upper*(b*b*upper + upper)
  if d<0:
    raise ValueError("desired location not possiable")
  #print(d)
  # if d < 0:
  #     roslogg
  yj = (y1 - a*b - math.sqrt(d))/(b*b + 1)
  zj = a + b*yj
  theta = 180.0*math.atan(-zj/(y1-yj))/math.pi
  if yj>y1:
      theta += 180.0
  return theta



def ik(x,y,z):
  upper=100
  lower=150
  Rf = 75
  Rm=48
  # o=[[x],[y],[z]]

  # #a b c= 0 since platform should stay level

  # angles=[0,0,0]
  # for i in range(3):
  #   L=np.array(o)+np.array(s[i])-np.array(u[i])
  #   length=np.norm(L,2)
  #   theta2=math.acos(upper/length)
  #   theta1=math.acos((Rf-Rm)/length)
  #   angles[i]=180-theta2-theta1

  cos120 = math.cos(2.0*math.pi/3.0)
  sin120 = math.sin(2.0*math.pi/3.0)

  theta1=calc_yz(x,y,z,upper,lower,Rf,Rm)
  theta2 = calc_yz(x*cos120 + y*sin120, y*cos120 - x*sin120, z,upper,lower,Rf,Rm) # rotate +120 deg
  theta3 = calc_yz(x*cos120 - y*sin120, y*cos120 + x*sin120, z,upper,lower,Rf,Rm) # rotate -120 deg

  return [int(theta1), int(theta2),int(theta3)]