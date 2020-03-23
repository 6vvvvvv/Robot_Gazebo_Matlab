function A = Angle_Axis2(M)
rz = atan2(M(2,1),M(1,1));
ry = atan2(-M(3,1),sqrt( (M(3,2)*M(3,2)) + (M(3,3)*M(3,3)) ));
rx = atan2(M(3,2),M(3,3));
A = [rx;ry;rz];
end