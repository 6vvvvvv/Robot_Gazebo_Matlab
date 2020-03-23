clc
% == Activators ==

    % == Workspace ==
        %Activate workspace
        show_workspace = 1;
        %step for thetas
        theta_step = 50;
    % ===============
    
    % == Jacobienne ==
        % Calcule des solutions
        show_solutions = 1;
    % ================
% ================

% == DATA ===
if show_workspace
    % Only used for the workspace
    alpha_w = Deg2Rad(65);

    d4_w = 0.75;
    d5_w = 0.5;

    % theta4_w = 0;
    % theta5_w = 0;
    % theta6_w = 0;
    % data = [alpha_w d4_w d5_w];
    % T = [1 2 3 4;8 5 2 1;7 5 3 1;9 5 1 4]
end
% ===========

% == DH ==
syms alpha d4 d5 theta4 theta5 theta6
DH = [0 alpha d4 theta4;0 -alpha d5 theta5;1 0 0 theta6+pi/2]

%Tests
% syms t1 t2 d2 d3
% DH = [0 -pi/2 0 t1;0 pi/2 d2 t2;0 0 d3 0]

% Mat_Hom = Calc_Mat_Hom(DH)
% ========

% == Workspace ==
if show_workspace
    workspace = [];
    for theta4_w = -150:theta_step:150
        for theta5_w = -150:theta_step:150
            for theta6_w = -150:theta_step:150
                data = [alpha_w d4_w d5_w theta4_w theta5_w theta6_w];
                workspace = cat(1,workspace,Calc_XYZ(data));
            end
        end
    end
    plot3(workspace(:,1),workspace(:,2),workspace(:,3),'.')
end
%================

% == Calcul de Jacobienne ==
T00 = Calc_Frame(DH,0);
T01 = Calc_Frame(DH,1);
T02 = Calc_Frame(DH,2);
T03 = Calc_Frame(DH,3);

z0 = T00(1:3,3);
z1 = T01(1:3,3);
z2 = T02(1:3,3);
ze = T03(1:3,3);

p0 = T00(1:3,4);
p1 = T01(1:3,4);
p2 = T02(1:3,4);
pe = T03(1:3,4);

J = [cross(z0,pe-p0) cross(z1,pe-p1) cross(z2,pe-p2);z0 z1 z2]
l1 = 1; l2 = 2; l3 = 3;
J_tronc = [J(l1,:);J(l2,:);J(l3,:)];

d = det(J_tronc)

if show_solutions
    sol_alpha = solve(d==0, alpha) 
    sol_d4 = solve(d==0, d4) 
    sol_d5 = solve(d==0, d5) 

    sol_theta4 = solve(d==0, theta4) 
    sol_theta5 = solve(d==0, theta5) 
    sol_theta6 = solve(d==0, theta6) 
end
% ==========================