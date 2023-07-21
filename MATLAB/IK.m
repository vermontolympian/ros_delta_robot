function [l, n, R,s] = IK(P)

o=P(1:3);
a=deg2rad(P(4));
b=deg2rad(P(5));
c=deg2rad(P(6));

Rm=500/2;
Rf=300/2;
RX=[cos(a) -sin(a) 0;
    sin(a) cos(a) 0;
    0       0      1];
RY=[cos(b) 0 sin(b);
    0      1 0;
    -sin(b) 0 cos(b)];
RZ=[cos(c) -sin(c) 0;
    sin(c) cos(c) 0;
    0       0      1];

R=RX*RY*RZ;

s1=[Rm; 0;0];
s2=[Rm*cosd(120); Rm*sind(120);0];
s3=[-Rm*cosd(120); -Rm*sind(120);0];

s=[s1 s2 s3];

u1=[Rf; 0;0];
u2=[Rf*cosd(120); Rf*sind(120);0];
u3=[-Rf*cosd(120); -Rf*sind(120);0];

u=[u1 u2 u3];

for i = 1:3
    L(:,i) = o + s(:,i) - u(:,i);
    l(i)=norm(L(:,i),2);
    n(:,i) = L(:,i)/l(i);
end

end