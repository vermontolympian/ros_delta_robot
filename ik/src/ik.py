#!/usr/bin/env python3
import numpy as np
import math
import rospy
from std_msgs.msg import String, Int32MultiArray
pos=[0,0,30]


def callback(data):
  storage=data.data
  for i in range(3):
    pos[i]=int(storage[i])

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



def ik(x,y,z,upper,lower,Rf,Rm):
  # upper=50
  # lower=100
  # Rf=500/2
  # Rm=300/2
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

def main():
  rospy.Subscriber("chatter", String, callback)
  pub = rospy.Publisher('publisher', Int32MultiArray, queue_size=10)
  rospy.init_node('IK_pub', anonymous=True)
  rate = rospy.Rate(10) # 10hz

  upper=rospy.get_param("/upper_link")
  lower=rospy.get_param("/lower_link")
  Rf=rospy.get_param("/Rf")
  Rm=rospy.get_param("/Rm")
  #print(upper)
  while not rospy.is_shutdown():
    servo_angle=ik(pos[0], pos[1],pos[2],upper,lower,Rf,Rm)
    my_msg= Int32MultiArray()
    my_msg.data = servo_angle
    pub.publish(my_msg)
    rate.sleep()

if __name__ == '__main__':
  try:
    main()
  except rospy.ROSInterruptException:
    pass  