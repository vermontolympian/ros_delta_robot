function J = JacVel(P)
[l, n,R,s] = IK(P);
J=[n(:,1)',cross(R*s(:,1),n(:,1))';
   n(:,2)',cross(R*s(:,2),n(:,2))';
   n(:,3)',cross(R*s(:,3),n(:,3))'];
end
