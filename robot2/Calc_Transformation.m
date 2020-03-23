function transf = Calc_Transformation(link)

a = link(1);
alpha = link(2);
d = link(3);
theta = link(4);

transf = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta);sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);0 sin(alpha) cos(alpha) d;0 0 0 1];

% transf = zeros(4);
% 
% transf(1,:) = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta)];
% transf(2,:) = [sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta)];
% transf(3,:) = [0 sin(alpha) cos(alpha) d];
% transf(4,:) = [0 0 0 1];

end