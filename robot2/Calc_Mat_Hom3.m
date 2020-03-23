function mat_hom = Calc_Mat_Hom3(DH,n)

mat_hom = eye(4);

for i = 1:n
    mat_hom = mat_hom * Calc_Transformation(DH(i,:));
end

end