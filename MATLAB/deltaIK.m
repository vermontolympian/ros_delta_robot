function omega = deltaIK(p, upper, lower)
    % DELTAIK(p, upper, lower)
    % This function takes in a vector of the x, y, z position of the
    % desired position (p) and the upper and lower leg lengths. It returns
    % omega, a vector of the joint angles

    % upper=50;
    % lower=100;
    Rf = 500/2;
    Rm = 300/2;

    x = p(1);
    y = p(2);
    z = p(3);

    p2 = [x*cosd(120) + y*sind(120)
          y*cosd(120) - x*sind(120)
          z];
    p3 = [x*cosd(120) - y*sind(120)
          y*cosd(120) + x*sind(120)
          z];

    theta1 = calc_yz(p, upper, lower, Rf, Rm);
    theta2 = calc_yz(p2, upper, lower, Rf, Rm);
    theta3 = calc_yz(p3, upper, lower, Rf, Rm);
    omega = [theta1 theta2 theta3]';
end