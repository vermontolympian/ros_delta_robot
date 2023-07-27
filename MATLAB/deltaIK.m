function omega = deltaIK(p)
    % DELTAIK(p, upper, lower)
    % This function takes in a vector of the x, y, z position of the
    % desired position (p) and the upper and lower leg lengths. It returns
    % omega, a vector of the joint angles

    servo=100;
    ee_bar=150;
    ee = 48;
    base = 75;
    
    x = p(1);
    y = p(2);
    z = p(3);

    p2 = [x*cosd(120) + y*sind(120)
          y*cosd(120) - x*sind(120)
          z];
    p3 = [x*cosd(120) - y*sind(120)
          y*cosd(120) + x*sind(120)
          z];
    plot3([x,p2(1),p3(1)],[y,p2(2),p3(2)],[z,z,z])
%     cos120 =cosd(120);
%     sin120 = sind(120);
    theta1 = rad2deg(calcYZ(p,ee_bar, servo , base, ee))+30;
    theta2 = rad2deg(calcYZ(p2, ee_bar, servo, base, ee))+30;
    theta3 = rad2deg(calcYZ(p3, ee_bar, servo, base, ee))+30;
    
%     theta1 = calcYZ([x0, y0, z0],upper, lower, Rf, Rm);
%     theta2 = calcYZ([x0*cos120 + y0*sin120, y0*cos120 - x0*sin120, z0],upper, lower, Rf, Rm); % rotate +120 deg
%     theta3 = calcYZ([x0*cos120 - y0*sin120, y0*cos120 + x0*sin120, z0],upper, lower, Rf, Rm); % rotate -120 deg
    omega = [theta1 theta2 theta3]'*-1;
    deg2rad([omega(1);omega(3);omega(2)])
end