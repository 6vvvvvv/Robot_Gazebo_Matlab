function [ T06 ] = ForwardKinematics( theta )
if nargin<2; 
end  
%[alpha a theta d ]  
T1 =Transd( 0, 0, theta(1), 0 );   
T2 =Transd( 0, 0, theta(2), 0 );
T3 =Transd( 0, 0, theta(3), 0 );
T4 =Transd( 0, 0, theta(4), 0 );
T5 =Transd( 0, 0, theta(5), 0 );
T6 =Transd( 0, 0, theta(6), 0 );
T06=T1*T2*T3*T4*T5*T6;
end
