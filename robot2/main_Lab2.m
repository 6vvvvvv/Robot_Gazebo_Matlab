clc
% == Activators ==
    % == Calcul de la Jabobienne ==
        do_jacobienne = 0;
    % =============================
    
    % == Étape III ==
    % ===============
% ================

% == DATA ==

syms t1 t2 t3 t4 t5 t6 t7 l1 l2 l3 l4 l5 l6 l7
thetas = [t1 t2 t3 t4 t5 t6 t7];
longs = [1 1 1 1 1 1 1];

% ==========

% == Calcul de la Jabobienne ==
if do_jacobienne
    % Calcul de la Jacobienne
    J = Calc_Jac(thetas,longs)
    Jp = J(1:2,:)
end
% =============================

% == Étape III ==

    % Data
tf = 3;
rate = 50;
eps = 10e-6;
q = [0 0 0 0 0 0 0]';
k1 = 1;

Pd = [4 3.5]';
Pe = [0 0]';

iter = 0;
e = Pd-Pe;
while abs(e) > eps
    iter = iter +1;
    J = Calc_Jac(q,longs);
    Jp = J(1:2,:);
    
    inv = pinv(Jp)*e;
    q = q + inv;
    
    T07 = Calc_Mat_Hom2(q,longs,7);
    Pe = T07(1:2,4);    
    e = Pd-Pe;
    
    
end

Pe
q
iter
% ===============