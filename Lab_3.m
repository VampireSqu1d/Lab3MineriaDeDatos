Map_Maligno = Casos(:,11)==4;
Malignos=Casos((Map_Maligno), :);
Map_Benigno = Casos(:,11)==2;
Benignos=Casos((Map_Benigno), :);
Num_malignos=size(Malignos, 1);
Num_Benignos=size(Benignos, 1);

%cálculo de probabilidad a priori
Prob_M = Probabilidad( Train, 11, 4 );
Prob_B = 1-Prob_M;

% Generamos un array con los valores ?nicos del campo 2 (clump thikness)
A=unique(Malignos(:, 2));
%generamos un mapa con los valores benignos (2) de la matriz Train
TrainMapaBeg= Train(:,11)==2;
%Generamos una matriz con los valores Benignos del mapa de la matriz Train
BUV = Train((TrainMapaBeg), :);
%generamos la tabla para los valores Benignos llamando a la funcion
%Counting que creamos
TablaBenignos = Counting(BUV, A );
%Generamos un mapa con los valores malignos (4) de la matriz Train
TrainMapaMag = Train(:, 11)==4;
%generamos una matriz con los valores malignos del mapa de la matriz Train
MUV = Train(( TrainMapaMag), :);
%generamos la tabla para los valores malignos llamando a la funcion
%Counting que creamos
TablaMalignos = Counting(MUV, A);
%sumamos los valores de la tabla para comprobar que el tamaño sea el
%correct
sum(TablaBenignos);
sum(TablaMalignos);
%sumar 1 a cada celda para evitar errores al normalizar
TablaBenignos2= [TablaBenignos(:,1),TablaBenignos(:,2:10) + 1];
TablaMalignos2= [TablaMalignos(:,1),TablaMalignos(:,2:10) + 1];

%normalizacion de los valores de la tabla de malignos
NormFacm = sum(TablaMalignos2(:,2));
ConteoMalignosNorm = [TablaMalignos(:,1), TablaMalignos2(:,2:10)/NormFacm];
%normalizacion de los valores de la tabla de Benignos
NormFacb = sum(TablaBenignos2(:,2));
ConteoBenignosNorm = [TablaBenignos(:,1), TablaBenignos2(:,2:10)/NormFacb];

%Desde aquí se comienza a trabajar con la matriz Test%

%creamos la matriz de valores benignos de la matriz test
TestMapaBenignos = Test(:, 11) == 2;
TestBenignos = Test((TestMapaBenignos), :);
%creamos la matriz de valores malignos de la matriz test
TestMapaMalignos = Test(:, 11) == 4;
TestMalignos = Test((TestMapaMalignos), :);




