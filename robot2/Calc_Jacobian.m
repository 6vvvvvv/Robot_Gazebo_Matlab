function J = Calc_Jacobian(TB0,DH,T5E)

% Calcul des matrices homogenes

TB1 = TB0*Calc_Mat_Hom3(DH,1);
TB2 = TB0*Calc_Mat_Hom3(DH,2);
TB3 = TB0*Calc_Mat_Hom3(DH,3);
TB4 = TB0*Calc_Mat_Hom3(DH,4);

TBE = TB4*T5E;

% Calcul des zi-1
z0 = TB0(1:3,3);
z1 = TB1(1:3,3);
z2 = TB2(1:3,3);
z3 = TB3(1:3,3);
z4 = TB4(1:3,3);
%ze = TBE(1:3,3);

% Calcul des p
p0 = TB0(1:3,4);
p1 = TB1(1:3,4);
p2 = TB2(1:3,4);
p3 = TB3(1:3,4);
p4 = TB4(1:3,4);
pe = TBE(1:3,4);

J = [cross(z0,pe-p0) cross(z1,pe-p1) cross(z2,pe-p2) cross(z3,pe-p3) cross(z4,pe-p4);z0 z1 z2 z3 z4];
end