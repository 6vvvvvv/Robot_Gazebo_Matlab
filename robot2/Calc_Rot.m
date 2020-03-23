function rot = Calc_Rot(axis,a)
Rx = [1 0 0;0 cos(a) -sin(a);0 sin(a) cos(a)];
Ry = [cos(a) 0 sin(a);0 1 0;-sin(a) 0 cos(a)];
Rz = [cos(a) -sin(a) 0;sin(a) cos(a) 0;0 0 1];
if axis == 1
    rot = Rx;
elseif axis == 2
    rot = Ry;
else
    rot = Rz;
end