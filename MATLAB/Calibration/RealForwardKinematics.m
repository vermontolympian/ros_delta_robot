% REAL FORWARD KINEMATICS.
% This function is the same as ForwardKinematics code but using
% "realjabobianV" and "realpod" instead of "jacobianV" and "pod"!


function p=RealForwardKinematics(P0,lg);
t=1;
Rm=125;
Rf=325;
alpha=40*pi/180;
beta=85*pi/180;
P(:,1)=P0;
i=2;
while t>0.0001
    X=P(1:3,i-1);
    teta=P(4:6,i-1);
    J=realjacobianV(P(:,i-1));
    [L,l,n]=realpod(P(:,i-1));
    Rp=[1,0,0,0,0,0;
        0,1,0,0,0,0;
        0,0,1,0,0,0;
        0,0,0,1,0,sin(teta(2));
        0,0,0,0,cos(teta(1)),-sin(teta(1))*cos(teta(2));
        0,0,0,0,sin(teta(1)),cos(teta(1))*cos(teta(2))];
    JRp=J*Rp;
    P(:,i)=P(:,i-1)-inv(JRp)*(l'-lg);
    t=norm(P(:,i)-P(:,i-1),2);
    i=i+1;
end
p=P(:,end);