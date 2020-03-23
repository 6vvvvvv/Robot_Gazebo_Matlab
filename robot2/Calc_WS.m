function workspace = Calc_WS(data,theta4,theta5,theta6)
thetas = [theta4 theta5 theta6]

% == Recovering Data ==
alpha = data(1);
d4 = data(2);
d5 = data(3);
% =====================

% == Converting thetas ==
theta4 = Deg2Rad(theta4);
theta5 = Deg2Rad(theta5);
theta6 = Deg2Rad(theta6);
% =======================

% == Calculating Homo Matrix ==
DH = [0 alpha d4 theta4;0 -alpha d5 theta5;1 0 0 theta6+pi/2]
Mat_Hom = Calc_Mat_Hom(DH)
% =============================
workspace = Mat_Hom;
end