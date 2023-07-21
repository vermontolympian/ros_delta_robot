%% Main
P0 =[ 0 0 200 0 0 0]';
%P0 =[ 50 50 50 0 0 0]';
lg=[250.1730, 247.7072, 253.3073]';
%lg=[122.4745  153.8189   79.6225]';
p=ForwardK(P0,lg)
%p=ForwardK(P0,lg,'XYZ')
%% FK
function p = ForwardK(P0 , lg)

%P0 = [0 10 150 0 0 0];
P(:,1)=P0;
i=2;
Dp=1;
dl=1;
e=0.001;
while dl  > e
    J = JacVel(P(:,i-1));
    a=P(4, i-1)*pi/180;
    b=P(5, i-1)*pi/180;
    c=P(6, i-1)*pi/180;

    B=[1 0 sin(b);
       0 cos(a)  -sin(a)*cos(b);
       0 sin(a)        cos(a)*cos(b)];
   
    T= [eye(3) zeros(3,3);
        zeros(3,3) B];

    [l, n, R,s] = IK(P(:,i-1));

    Dl = lg - l';

    P(:,i) = P(:,i-1) + pinv(J*T) * Dl;
    
    dl = norm(P(:,i)-P(:,i-1),2)
    %dl = norm(Dl ,2)
    i=i+1;
end



p(1:3)=P(1:3,end);
p(4)=rad2deg(P(4,end));
p(5)=rad2deg(P(5,end));
p(6)=rad2deg(P(6,end));
end


% function p = ForwardK(P0, lg, euler)
% 
% %% Robot Parameters (Given)
% Rm = 250/2;
% Rf = 650/2;
% alpha = 40 * pi / 180;
% beta = 80 * pi /180;
% 
% %% Initial Guess
% % P0 = [0 0 150 0 0 0]; % Step 1
% 
% P(:,1) = P0;
% i = 2;
% 
% %% Iteratice Loop
% Dp = 1;
% e = 0.0015;
% 
% while Dp > e
%     J = JacVel(P(:, i-1)); % Step 2
%     
%     % Step 3 (ZYZ Euler Angles in deprees)
%     a = P(4, i-1) * pi/180;
%     b = P(5, i-1) * pi/180;
%     c = P(6, i-1) * pi/180;
% 
% 
%     %% Calculate B Matrix for any given Euler configuration
%     syms theta;
%     Rx = [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)];
%     Ry = [cos(theta), 0, sin(theta); 0, 1, 0; -sin(theta), 0, cos(theta)];
%     Rz = [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
% 
%     B = eye(3);
%     midR = eye(3);
% 
%      B=[1 0 sin(b);
%        0 cos(a)  -sin(a)*cos(b);
%        0 sin(a)        cos(a)*cos(b)];
%     T = [eye(3) zeros(3,3)
%          zeros(3,3), B];
%     
%     % Step 4
%     %[l, n, R, s] = IK(P(:,i-1));
%     [l, n, R,s] = IK(P(:,i-1));
%     Dl = lg - l';
%     
%     P(:,i) = P(:, i-1) + pinv(J*T) * Dl; % Step 5
%     % P(:,i) = P(:, i-1) + (J*T) \ Dl; % Step 5
% 
%     % Step 6
%     Dp = norm(P(:,i) - P(:,i-1), 2)
%     i = i + 1;
% end
% p = P(:,end);
% end
%% IK
% <include>IK.m</include>
%% JacVel
% <include>JacVel.m</include>