clc
% == Activators ==
    % == DH ==
        use_syms = 0;
    % ========
    
    % == Partie II ==
        show_partie1 = 1;
        show_partie2 = 1;
        show_plot = 1;
        generate_TSV = 0;
    % ===============
% ================

% == DATA ==

if use_syms
    syms Lx_hip Ly_hip Lz_hip Lthigh Ltibia Lfoot Lx_knee
    %syms r_hip_joint r_thigh_joint r_knee_joint r_ankle_joint r_foot_joint
    syms Px Py Pz  
    
    r_hip_joint = 0;
    r_thigh_joint = 0;
    r_knee_joint = 0;
    r_ankle_joint = 0;
    r_foot_joint = 0;
else
    %Dimensions physique du Darwin-Mini
    Lx_hip = 0.015;
    Ly_hip = 0.024;
    Lz_hip = 0.027;
    Lthigh = 0.045;
    Ltibia = 0.042;
    Lfoot = 0.031;
    Lx_knee = 0.03;

    %Description des joints de la jambe droite
    aThigh = 0.3*atan(Lx_knee/Lthigh);
    aTibia = atan(Lx_knee/Ltibia);

    r_hip_joint = -0.45;
    r_thigh_joint = -aThigh;
    r_knee_joint = aThigh+aTibia;
    r_ankle_joint = aTibia;
    r_foot_joint = -0.45;
    %syms r_foot_joint
    %Posotion désiré du pas quasi-statique
    Px = 0.03;
    Py = -0.01;
    Pz = 0;
end
%===========

% == DH ==

TB0 = [0 0 1 -Lx_hip;1 0 0 -Ly_hip;-0 1 0 -Lz_hip;0 0 0 1];

DH = [0 -pi/2 0 r_hip_joint-pi/2;Lthigh 0 0 r_thigh_joint;Ltibia pi 0 r_knee_joint;0 pi/2 0 r_ankle_joint];
T05 = Calc_Mat_Hom(DH);

T5E = [0 sin(r_foot_joint) -cos(r_foot_joint) Lfoot;0 -cos(r_foot_joint) -sin(r_foot_joint) 0;-1 0 0 0;0 0 0 1];

TBE = TB0*T05*T5E;


% ========


% == Trajectoire ==

    % == Partie I ==
    % Dans cette section on va faire en sorte que le pieds atteigne la
    % moitié de la trajectoire soit Pinter = [0.015 -0.01 0.02]'
    if show_partie1
        % Data
        Pe = [0 0 0]';
        %Pd = [0.015 0.02]';

        q = [r_hip_joint r_thigh_joint r_knee_joint r_ankle_joint r_foot_joint]';

        %e = Pd - Pe;
        eps = 10e-6;
        i=0;
        ploute = Pe';
        q_plot = q';

        rate = 50;
        
        a2x = 0.015/3;
        a3x = -6*a2x/27;
       
        a2y = -0.005/3;
        a3y = -6*a2y/27;
        
        
        a2z = 0.02/3;
        a3z = -6*a2z/27;
        
%         ad = [0 0 0]';
        t = 0;
        i=0;
        for k = 1:rate
            t = t+3/rate;
            Pd = [a3x*t^3+a2x*t^2 a3y*t^3+a2y*t^2 a3z*t^3+a2z*t^2]'
            e = Pd - Pe;
            
            while abs(e(1)) > eps || abs(e(2)) > eps || abs(e(3)) > eps
                i=i+1;

                J = Calc_Jacobian(TB0,DH,T5E);
                %Jp = cat(1,J(1,:),J(3,:));
                Jp= J(1:3,:);
%                 J2= J(4:6,:);% pour avoir pied parralele
                inv = pinv(Jp)*e;
                q = q + inv;

                DH = [0 -pi/2 0 q(1)-pi/2;Lthigh 0 0 q(2);Ltibia pi 0 q(3);0 pi/2 0 q(4)];
                T5E = [0 sin(q(5)) -cos(q(5)) Lfoot;0 -cos(q(5)) -sin(q(5)) 0;-1 0 0 0;0 0 0 1];

                TBE = TB0*Calc_Mat_Hom(DH)*T5E;
                
%                 e0= ad - Angle_Axis2(TBE(1:3,1:3));
% %                 === boucle pour parametrer l'angle ===
%                 while abs(e0(1)) > eps || abs(e0(2)) > eps || abs(e0(3)) > eps  
%                     phi=Jp'*((Jp*Jp')^-1)*e;
%                     J2chapo=J2*(eye(5)-Jp'*((Jp*Jp')^-1)*Jp);
%                     pie=J2chapo'*((J2chapo*J2chapo')^-1)*(e0-J2*phi);
%                     q = q + phi + pie
%                     DH = [0 -pi/2 0 q(1)-pi/2;Lthigh 0 0 q(2);Ltibia pi 0 q(3);0 pi/2 0 q(4)];
%                     T5E = [0 sin(q(5)) -cos(q(5)) Lfoot;0 -cos(q(5)) -sin(q(5)) 0;-1 0 0 0;0 0 0 1];
% 
%                     TBE = TB0*Calc_Mat_Hom(DH)*T5E;
%                     e0= ad - Angle_Axis2(TBE(1:3,1:3))
%                 
%                 end
%                 ====================================================
                %Pe = cat(1,T0E(1,4),T0E(3,4));
                Pe = TBE(1:3,4);
                e = Pd-Pe;
                if i > 12
                    ploute = cat(1,ploute,Pe');
                    q_plot = cat(1,q_plot,q');
                end
            end
            Pe = Pd;
            
        end
        
        %plot(ploute(:,1),ploute(:,2))
    end
    % ==============
    
    % == Partie II ==
    % Dans cette section on va faire en sorte que le pieds atteigne la
    % fin de la trajectoire soit Pd = [0.03 -0.01 0]
    if show_partie2
        % Data
        Pe = [0.015 -0.05 0.02]';
        %Pd = [0.03 0]';
        
            rate = 50;
            
    a0x = 0.015;        
    a2x = 0.005;
    a3x = -6*a2x/27;
    
    a0y = -0.005;
    a2y = a0y/3;
    a3y = -6*a2y/27;
    
    
    a0z = 0.02;
    a2z = -a0z/3;
    a3z = -6*a2z/27;
    
    
    t = 0;
    i=0;

        %q = [r_hip_joint r_thigh_joint r_knee_joint r_ankle_joint r_foot_joint]';

        %e = Pd - Pe;
        %i=0;
        
        for k = 1:rate
            t = t+3/rate;
            Pd = [a3x*t^3+a2x*t^2+a0x a3y*t^3+a2y*t^2+a0y a3z*t^3+a2z*t^2+a0z]';
            e = Pd - Pe;
            
            while abs(e(1)) > eps || abs(e(2)) > eps || abs(e(3)) > eps
                i=i+1;

                J = Calc_Jacobian(TB0,DH,T5E);
                %Jp = cat(1,J(1,:),J(3,:));
                Jp= J(1:3,:);

                inv = pinv(Jp)*e;
                q = q + inv;

                DH = [0 -pi/2 0 q(1)-pi/2;Lthigh 0 0 q(2);Ltibia pi 0 q(3);0 pi/2 0 q(4)];
                T5E = [0 sin(q(5)) -cos(q(5)) Lfoot;0 -cos(q(5)) -sin(q(5)) 0;-1 0 0 0;0 0 0 1];

                TBE = TB0*Calc_Mat_Hom(DH)*T5E;
                %Pe = cat(1,T0E(1,4),T0E(3,4));
                Pe = TBE(1:3,4);
                e = Pd-Pe;
                if i>8
                    ploute = cat(1,ploute,Pe');
                    q_plot = cat(1,q_plot,q');
                end
                
            end
        end
        
    end
    
    if show_plot
        ploute
        plot(ploute(:,1),ploute(:,3))
    end
    % ===============

    % == TSV ==
    if generate_TSV
        dlmwrite('data.txt',q_plot,'delimiter','\t','precision',3);
    end
    % =========
% =================