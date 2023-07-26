function theta = calcYZ(p, end_effector_rod, servo_arm, base, ee)
    x=p(1);
    y=p(2);
    z=p(3);
    y1 = -base;
    y=y-ee;
    a = (x^2 + y^2 + z^2 + servo_arm*servo_arm - end_effector_rod*end_effector_rod - y1*y1)/(2*z);
    b = (y1-y)/z;
    d = -(a + b*y1)*(a + b*y1) + servo_arm*(b^2*servo_arm + servo_arm);
    yj = (y1 - a*b -sqrt(d))/(b^2 + 1);
    zj = a + b*yj;
    theta = atan(-zj/(y1-yj));
    if yj > y1
      theta = theta + pi;
    end
end