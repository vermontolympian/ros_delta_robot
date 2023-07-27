function F=Simulation(x)
%% Input Nominal s and u values from Table 1 in the paper.
Rm=125;
Rf=325;
alpha=40*pi/180;
beta=85*pi/180;
st=[Rm*cos(beta/2),-Rm*sin(pi/6-beta/2),-Rm*sin(pi/6+beta/2),-Rm*cos(pi/3-beta/2),-Rm*cos(pi/3+beta/2),Rm*cos(beta/2);
   Rm*sin(beta/2),Rm*cos(pi/6-beta/2),Rm*cos(pi/6+beta/2),-Rm*sin(pi/3-beta/2),-Rm*sin(pi/3+beta/2),-Rm*sin(beta/2);
   0,0,0,0,0,0];
ut=[Rf*cos(alpha/2),-Rf*sin(pi/6-alpha/2),-Rf*sin(pi/6+alpha/2),-Rf*cos(pi/3-alpha/2),-Rf*cos(pi/3+alpha/2),Rf*cos(alpha/2);
   Rf*sin(alpha/2),Rf*cos(pi/6-alpha/2),Rf*cos(pi/6+alpha/2),-Rf*sin(pi/3-alpha/2),-Rf*sin(pi/3+alpha/2),-Rf*sin(alpha/2);
   0,0,0,0,0,0];
%%
% Now consider m arbitrary configurations, but close to the boundary or the
% workspace not in the middle of the workspace.
%Choose as many configurations as you want.
%You can replace the following configurations with your own selected configurations.

     pt=[
         
 -175.0000  175.0000  565.4000   -0.0500   -0.0500   -0.0500
  175.0000 -175.0000  565.4000    0.0500    0.0500   -0.0500
  175.0000  175.0000  565.4000    0.0500   -0.0500    0.0500
  -175.0000  175.0000  900.0000   -0.0500    0.0500   -0.0500
  -175.0000  175.0000  900.0000    0.0500   -0.0500    0.0500
  -175.0000  175.0000  565.4000    0.0500    0.0500    0.0500
   175.0000  175.0000  565.4000   -0.0500    0.0500   -0.0500
  -175.0000 -175.0000  565.4000   -0.0500   -0.0500   -0.0500
    175.0000 -175.0000  565.4000    0.0500   -0.0500   -0.0500
    175.0000 -175.0000  900.0000   -0.0500    0.0500    0.0500
  -175.0000 -175.0000  565.4000   -0.0500    0.0500   -0.0500

];

%% ### m is the number of selected configurations:

m=11;

%% Calculate the real configurations (measured poses)
   for i=1:m   
       pm(i,1:6)=(RealForwardKinematics(pt(i,:)',(pod(pt(i,:)')')))';
   end
   
 %% Calculate the Cost Function:  
 j=0;
 for k=1:m   
     %Calculating Nominal and Real (Measured) Rotation Matrices.
     Rt=[cos(pt(k,6))*cos(pt(k,5)),-sin(pt(k,6))*cos(pt(k,4))+sin(pt(k,4))*sin(pt(k,5))*cos(pt(k,6)),sin(pt(k,4))*sin(pt(k,6))+cos(pt(k,4))*cos(pt(k,6))*sin(pt(k,5));
         sin(pt(k,6))*cos(pt(k,5)),cos(pt(k,6))*cos(pt(k,4)),sin(pt(k,4))*sin(pt(k,5))*sin(pt(k,6));
         -sin(pt(k,5)),sin(pt(k,4))*cos(pt(k,5)),cos(pt(k,4))*cos(pt(k,5))];
     Rm=[cos(pm(k,6))*cos(pm(k,5)),-sin(pm(k,6))*cos(pm(k,4))+sin(pm(k,4))*sin(pm(k,5))*cos(pm(k,6)),sin(pm(k,4))*sin(pm(k,6))+cos(pm(k,4))*cos(pm(k,6))*sin(pm(k,5));
         sin(pm(k,6))*cos(pm(k,5)),cos(pm(k,6))*cos(pm(k,4)),sin(pm(k,4))*sin(pm(k,5))*sin(pm(k,6));
         -sin(pm(k,5)),sin(pm(k,4))*cos(pm(k,5)),cos(pm(k,4))*cos(pm(k,5))];
     for i=1:6
         j=j+1;
         L(:,i)=Rt*st(:,i)+(pt(k,1:3))'-ut(:,i); %Nominal IK
         l(i)=norm(L(:,i),2); %Nominal leg lengths from Nominal IK
         lo=pod([0,0,565.4,0,0,0]'); %Nominal initial leg lentghs in the home position of the robot.
         F(j)=((l(i))^2-((lo(i)+norm([pm(k,1:3)]'+Rm*x(1:3,i)-x(4:6,i))-x(7,i))^2))^2; %We can rewrite eq. 10 (in the paper) like this.
     end
 end