function J = Calc_Jac(T,L)

% Calcul des matrices homogenes
T00 = Calc_Mat_Hom2(T,L,0);
T01 = Calc_Mat_Hom2(T,L,1);
T02 = Calc_Mat_Hom2(T,L,2);
T03 = Calc_Mat_Hom2(T,L,3);
T04 = Calc_Mat_Hom2(T,L,4);
T05 = Calc_Mat_Hom2(T,L,5);
T06 = Calc_Mat_Hom2(T,L,6);
T07 = Calc_Mat_Hom2(T,L,7);

% Calcul des zi-1
z0 = T00(1:3,3);
z1 = T01(1:3,3);
z2 = T02(1:3,3);
z3 = T03(1:3,3);
z4 = T04(1:3,3);
z5 = T05(1:3,3);
z6 = T06(1:3,3);
%ze = T07(1:3,3);

% Calcul des p
p0 = T00(1:3,4);
p1 = T01(1:3,4);
p2 = T02(1:3,4);
p3 = T03(1:3,4);
p4 = T04(1:3,4);
p5 = T05(1:3,4);
p6 = T06(1:3,4);
pe = T07(1:3,4);

J = [cross(z0,pe-p0) cross(z1,pe-p1) cross(z2,pe-p2) cross(z3,pe-p3) cross(z4,pe-p4) cross(z5,pe-p5) cross(z6,pe-p6);z0 z1 z2 z3 z4 z5 z6];
end