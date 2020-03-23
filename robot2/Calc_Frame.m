function frame = Calc_Frame(DH,n)

frame = eye(4);

for i = 1:n
    frame = frame * Calc_Transformation(DH(i,:));
end

end
