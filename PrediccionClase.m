function [predicClaseM] = PrediccionClase(TestMUV, TestConteoMalignosNorm, TestConteoBenignosNorm)
num_reg = 1;
s = TestMUV;
predicClaseM = zeros(size(TestMUV, 1), 1);
for c =1: size(s,1)
    ProbsB = 1;
    ProbsM = 1;
   for col = 2: 9
       %se toma el valor de la columna a evaluar en ambas tablas
       valor= s(num_reg, col);
       %se encuentra el indice en la tabla de malignos
       idx= find(TestConteoMalignosNorm(:, 1)==valor);
       %se multiplica el valor de la tabla de malignos
       ProbsM = ProbsM * TestConteoMalignosNorm(idx, col);
       
       %se encuentra el indice en la tabla de benignos
       idxb= find(TestConteoBenignosNorm(:, 1)==valor);
       %se multiplica el valor de la tabla de benignos
       ProbsB = ProbsB * TestConteoBenignosNorm(idxb, col);
   end
   if ProbsM > ProbsB
       predicClaseM(num_reg,1) = 4;
   else
       predicClaseM(num_reg,1) = 2;
   end
  num_reg = num_reg + 1;
end
end