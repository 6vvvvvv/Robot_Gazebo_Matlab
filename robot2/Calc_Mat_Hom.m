function mat_hom = Calc_Mat_Hom(DH)

mat_hom = eye(4);

for i = 1:length(DH(:,1))
    mat_hom = mat_hom * Calc_Transformation(DH(i,:));
end

end