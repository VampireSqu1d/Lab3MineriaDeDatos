function [Prob] = Probabilidad( Matrix_Casos, Columna, valor_col )
%Calcula la probabilidad de tener el valor_col en la columna
%indicada. En este caso Matrix_Casos será Train
%Calcular num de registros de Matrix_casos
% Probabilidad = Num eventos / N
% Prob = Num de coincidencias del valor_col en Columna / Total de registros en
    N = size(Matrix_Casos, 1);
    mapa_eventos = Matrix_Casos(:,Columna)==valor_col;
    eventos = Matrix_Casos((mapa_eventos), :);
    num_eventos = size(eventos,1);
    
    Prob = num_eventos / N ;
end


