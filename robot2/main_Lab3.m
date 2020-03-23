clc
% == Activators ==
    % == Calcul de la Jabobienne ==
        do_jacobienne = 1;
    % =============================
% ================


% == DATA ==

syms t1 t2 t3 t4 t5 t6 t7 l1 l2 l3 l4 l5 l6 l7
thetas = [t1 t2 t3 t4 t5 t6 t7];
longs = [l1 l2 l3 l4 l5 l6 l7];

% ==========

% == Calcul de la Jabobienne ==
if do_jacobienne
    % Calcul de la Jacobienne
    J = Calc_Jac(thetas,longs)
    Jo = J(1:2,:)
end
% =============================