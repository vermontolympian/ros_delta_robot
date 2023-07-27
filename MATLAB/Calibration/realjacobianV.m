%% REAL
% This code is the same as jaboanV but using real s from Table 2 of the
% paper instead of nominal s (Table 1)!


function J=realjacobianV(P)
Rm=125;
Rf=325;
alpha=40*pi/180;
beta=85*pi/180;
Xp=P(1:3,1);
teta=P(4:6,1);
[L,l,n]=realpod(P);
R=[cos(teta(3))*cos(teta(2)),-sin(teta(3))*cos(teta(1))+sin(teta(1))*sin(teta(2))*cos(teta(3)),sin(teta(1))*sin(teta(3))+cos(teta(1))*cos(teta(3))*sin(teta(2));
    sin(teta(3))*cos(teta(2)),cos(teta(3))*cos(teta(1)),sin(teta(1))*sin(teta(2))*sin(teta(3));
    -sin(teta(2)),sin(teta(1))*cos(teta(2)),cos(teta(1))*cos(teta(2))];

% Real s from Table 2 in the paper:
s=[Rm*cos(beta/2),-Rm*sin(pi/6-beta/2),-Rm*sin(pi/6+beta/2),-Rm*cos(pi/3-beta/2),-Rm*cos(pi/3+beta/2),Rm*cos(beta/2);
   Rm*sin(beta/2),Rm*cos(pi/6-beta/2),Rm*cos(pi/6+beta/2),-Rm*sin(pi/3-beta/2),-Rm*sin(pi/3+beta/2),-Rm*sin(beta/2);
   0,0,0,0,0,0]+[    4.5013   -4.8074   -3.2373   -1.4713   -2.2781   -0.8135
                    -2.6886           3.2141   -0.9429    3.1317   -3.0119    3.4622
                     1.0684          -0.5530    4.3547   -4.9014   -4.8473    0.2515];  
  
            
J=[n(:,1)',cross(R*s(:,1),n(:,1))';
    n(:,2)',cross(R*s(:,2),n(:,2))';
    n(:,3)',cross(R*s(:,3),n(:,3))';
    n(:,4)',cross(R*s(:,4),n(:,4))';
    n(:,5)',cross(R*s(:,5),n(:,5))';
    n(:,6)',cross(R*s(:,6),n(:,6))'];