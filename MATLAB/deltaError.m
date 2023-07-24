function eRSS = deltaError(nom, real, P)
%DELTAERROR Calculates the RSS error at a point given the nominal and real
%   values
%   NOM = nominal robot values
%   REAL = real robot values
%   P = position (6x1 column vector)

deltaRho = reshape(nom - real, [], 1);  % Turn deltaRho into column vector

Jv = JacVel(P);
[~, n, R, ~] = IK(P);
    
JR = [n'*R -n' -ones(6,1)];
JRho = [JR(1,:) zeros(1,35);
        zeros(1,7) JR(2,:) zeros(1,28);
        zeros(1,14) JR(3,:) zeros(1,21);
        zeros(1,21) JR(4,:) zeros(1,14);
        zeros(1,28) JR(5,:) zeros(1,7);
        zeros(1,35) JR(6,:)];
   
deltaP = pinv(Jv) * (-JRho * deltaRho);
eRSS = sqrt((deltaP(1)^2) + (deltaP(2)^2)  + (deltaP(3)^2));
end