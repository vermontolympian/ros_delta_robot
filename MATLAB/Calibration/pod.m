%pod(P) - NOMINAL

function l=pod(P)
Rm=125;
Rf=325;
alpha=40*pi/180;
beta=85*pi/180;
Xp=P(1:3,1);
teta=P(4:6,1);
 R=[cos(teta(3))*cos(teta(2)),-sin(teta(3))*cos(teta(1))+sin(teta(1))*sin(teta(2))*cos(teta(3)),sin(teta(1))*sin(teta(3))+cos(teta(1))*cos(teta(3))*sin(teta(2));
    sin(teta(3))*cos(teta(2)),cos(teta(3))*cos(teta(1)),sin(teta(1))*sin(teta(2))*sin(teta(3));
    -sin(teta(2)),sin(teta(1))*cos(teta(2)),cos(teta(1))*cos(teta(2))];


%% From Table 1 in the paper:
s=[Rm*cos(beta/2),-Rm*sin(pi/6-beta/2),-Rm*sin(pi/6+beta/2),-Rm*cos(pi/3-beta/2),-Rm*cos(pi/3+beta/2),Rm*cos(beta/2);
   Rm*sin(beta/2),Rm*cos(pi/6-beta/2),Rm*cos(pi/6+beta/2),-Rm*sin(pi/3-beta/2),-Rm*sin(pi/3+beta/2),-Rm*sin(beta/2);
   0,0,0,0,0,0];


%% From Table 1 in the paper:
u=[Rf*cos(alpha/2),-Rf*sin(pi/6-alpha/2),-Rf*sin(pi/6+alpha/2),-Rf*cos(pi/3-alpha/2),-Rf*cos(pi/3+alpha/2),Rf*cos(alpha/2);
    Rf*sin(alpha/2),Rf*cos(pi/6-alpha/2),Rf*cos(pi/6+alpha/2),-Rf*sin(pi/3-alpha/2),-Rf*sin(pi/3+alpha/2),-Rf*sin(alpha/2);
    0,0,0,0,0,0];

%% Calculate leg lengths using IK: (Xp and R are given, but s and u are from Table 1 in the paper)
for i=1:6
    L(:,i)=R*s(:,i)+Xp-u(:,i);
    l(i)=norm(L(:,i),2);
    n(:,i)=L(:,i)/l(i);
end
%L is the vector of each pod and l is a vector containing the lengths of
%pods