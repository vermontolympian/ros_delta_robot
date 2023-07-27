
function [L,l,n]=realpod(P)
Rm=125;
Rf=325;
alpha=40*pi/180;
beta=85*pi/180;
Xp=P(1:3,1);
teta=P(4:6,1);
R=[cos(teta(3))*cos(teta(2)),-sin(teta(3))*cos(teta(1))+sin(teta(1))*sin(teta(2))*cos(teta(3)),sin(teta(1))*sin(teta(3))+cos(teta(1))*cos(teta(3))*sin(teta(2));
    sin(teta(3))*cos(teta(2)),cos(teta(3))*cos(teta(1)),sin(teta(1))*sin(teta(2))*sin(teta(3));
    -sin(teta(2)),sin(teta(1))*cos(teta(2)),cos(teta(1))*cos(teta(2))];
%R is the rotation matrix

%% Create (bring in) real s matrix from Table 2 of the paper:

s=[Rm*cos(beta/2),-Rm*sin(pi/6-beta/2),-Rm*sin(pi/6+beta/2),-Rm*cos(pi/3-beta/2),-Rm*cos(pi/3+beta/2),Rm*cos(beta/2);
   Rm*sin(beta/2),Rm*cos(pi/6-beta/2),Rm*cos(pi/6+beta/2),-Rm*sin(pi/3-beta/2),-Rm*sin(pi/3+beta/2),-Rm*sin(beta/2);
   0,0,0,0,0,0]+[    4.5013   -4.8074   -3.2373   -1.4713   -2.2781   -0.8135
                    -2.6886           3.2141   -0.9429    3.1317   -3.0119    3.4622
                     1.0684          -0.5530    4.3547   -4.9014   -4.8473    0.2515];

                 
%% Create (bring in) real u matrix from Table 2 of the paper:  

u=[Rf*cos(alpha/2),-Rf*sin(pi/6-alpha/2),-Rf*sin(pi/6+alpha/2),-Rf*cos(pi/3-alpha/2),-Rf*cos(pi/3+alpha/2),Rf*cos(alpha/2);
    Rf*sin(alpha/2),Rf*cos(pi/6-alpha/2),Rf*cos(pi/6+alpha/2),-Rf*sin(pi/3-alpha/2),-Rf*sin(pi/3+alpha/2),-Rf*sin(alpha/2);
    0,0,0,0,0,0]+ [   -0.1402    1.1543    4.1690   -3.6111    2.4679   -2.9735
                       3.9130    2.9194   -0.8973   -2.9723   -0.5490    1.7214
                       2.6210    4.2181    3.9365   -3.0128    4.3181    3.3812];

%% Calculate the initial leg legth error using the last columns of Table 1 and Table 2 of the paper.

 lonominal=[604.8652  604.8652  604.8652  604.8652  604.8652  604.8652];
 loreal=[604.4299  607.2473  600.4441  605.9031  604.5251  600.0616];
 loerror=loreal-lonominal;

 %% Calculate leg lengths using IK:
for i=1:6
    L(:,i)=R*s(:,i)+Xp-u(:,i);
    l(i)=norm(L(:,i),2)-loerror(i); % Here, we must deduct initial leg length errors to get the real leg lengths. l(i) is now calculated considering 42 real kinematic parameters.
    n(:,i)=L(:,i)/l(i);
end
%L is the vector of each pod and l is a vector containing the lengths of
%pods