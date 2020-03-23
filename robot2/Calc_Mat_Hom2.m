function mat_hom = Calc_Mat_Hom2(T,L,n)

mat_hom = eye(4);

t=0; px=0; py=0;
for i = 1:n
    t=t+T(i);
    
    temp = 0;   
    for k = 1:i
        temp = temp + T(k);
    end
    
    px = px + L(i)*cos(temp);
    py = py + L(i)*sin(temp);
    
    mat_hom = [cos(t) -sin(t) 0 px;sin(t) cos(t) 0 py;0 0 1 0;0 0 0 1];
    
end

end