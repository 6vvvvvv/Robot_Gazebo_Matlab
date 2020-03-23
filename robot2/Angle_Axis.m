function A = Angle_Axis(M)
rz = acos( (M(1,1)+M(2,2)+M(3,3)-1) / 2 );
r = (1/(2*sin(rz))) * [M(3,2)-M(2,3);M(1,3)-M(3,1);M(2,1)-M(1,2)];
rx = asin( (r(2)/sqrt(r(1)*r(1) + r(2)*r(2))));
ry = acos(r(3));
A = [rx;ry;rz];
end