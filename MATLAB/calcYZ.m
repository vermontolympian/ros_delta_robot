function theta = calcYZ(p, upper, lower, Rf, Rm)
    y1 = -Rf;
    y = -Rm;
    a = (x*x + y*y + z*z + upper*upper - lower*lower - y1*y1)/(2*z);
    b = (y1-y)/z;
    d = -(a + b*y1)*(a + b*y1) + upper*(b*b*upper + upper);
    yj = (y1 - a*b - math.sqrt(d))/(b*b + 1);
    zj = a + b*yj;
    theta = 180.0*math.atan(-zj/(y1-yj))/math.pi;
    if yj > y1
      theta = theta + 180;
    end
end