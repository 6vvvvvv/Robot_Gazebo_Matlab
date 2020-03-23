function xyz = Calc_XYZ(data)

% == Recovering Data ==
alpha = data(1);
d4 = data(2);
d5 = data(3);
theta4 = Deg2Rad(data(4));
theta5 = Deg2Rad(data(5));
theta6 = Deg2Rad(data(6));
% =====================

% == Calculating Homo Matrix ==
DH = [0 alpha d4 theta4;0 -alpha d5 theta5;1 0 0 theta6+pi/2];
Mat_Hom = Calc_Mat_Hom(DH);
% =============================

xyz = Mat_Hom(1:3,4)';
end