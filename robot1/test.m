%establish jacobian
function [ JT ] = test( theta )
T01 = Transr( 0, 0, theta(1), 0 );
T12 = Transr( 0, 0, theta(2), 0 );
T23 = Transr( 0, 0, theta(3), 0 );
T34 = Transr( 0, 0, theta(4), 0 );
T45 = Transr( 0, 0, theta(5), 0 );
T56 = Transr( 0, 0, theta(6), 0 );
T02 = T01*T12;
T03 = T01*T12*T23;
T04 = T01*T12*T23*T34;
T05 = T01*T12*T23*T34*T45;
T06 = T01*T12*T23*T34*T45*T56;

T00 = [1 0 0 0;0 1 0 0; 0 0 1 0; 0  0 0 1]; 

%position of end-effector
ox = T06(1,4); 
oy = T06(2,4);
oz = T06(3,4);
w1 = T00(1:3,3);
w2 = T01(1:3,3);
w3 = T02(1:3,3);
w4 = T03(1:3,3);
w5 = T04(1:3,3);
w6 = T05(1:3,3);

% linear velocity and angular velocity 
J11 = diff(ox,theta(1));J12 = diff(ox,theta(2));J13 = diff(ox,theta(3));J14 = diff(ox,theta(4));J15 = diff(ox,theta(5));J16 = diff(ox,theta(6));
J21 = diff(oy,theta(1));J22 = diff(oy,theta(2));J23 = diff(oy,theta(3));J24 = diff(oy,theta(4));J25 = diff(oy,theta(5));J26 = diff(oy,theta(6));
J31 = diff(oz,theta(1));J32 = diff(oz,theta(2));J33 = diff(oz,theta(3));J34 = diff(oz,theta(4));J35 = diff(oz,theta(5));J36 = diff(oz,theta(6));

JT = [J11,J12,J13,J14,J15,J16;
      J21,J22,J23,J24,J25,J26;
      J31,J32,J33,J34,J35,J36;
       w1, w2, w3, w4, w5, w6];
end
