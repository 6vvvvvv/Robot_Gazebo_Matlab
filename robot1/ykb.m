function [ J, Jp] = ykb( agl )
syms a1 a2 a3 a4 a5 a6;
theta =[a1 a2 a3 a4 a5 a6];
JT =test( theta );
q = agl*pi/180;

JT1=subs(JT,a1,q(1));
JT2=subs(JT1,a2,q(2));
JT3=subs(JT2,a3,q(3));
JT4=subs(JT3,a4,q(4));
JT5=subs(JT4,a5,q(5));

J=subs(JT5,a6,q(6));
old = digits;
digits(4)
J = vpa(J,8);

Jp = pinv(J)
old = digits;
digits(4)
Jp = vpa(Jp,8);
end