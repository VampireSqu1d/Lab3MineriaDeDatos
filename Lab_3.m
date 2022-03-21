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
TestBUV = Test((TestMapaBenignos), :);
TestTablaBenignos = Counting(TestBUV, A);
%creamos la matriz de valores malignos de la matriz test
TestMapaMalignos = Test(:, 11) == 4;
TestMUV = Test((TestMapaMalignos), :);
TestTablaMalignos = Counting(TestMUV, A);

%sumamos 1 a todas las celdas para evitar errores
TestTablaBenignos2= [TestTablaBenignos(:,1),TestTablaBenignos(:,2:10) + 1];
TestTablaMalignos2= [TestTablaMalignos(:,1),TestTablaMalignos(:,2:10) + 1];
%normalizamos los valores malignos las matrices de test
TestNormFacm = sum(TestTablaMalignos2(:,2));
TestConteoMalignosNorm = [TestTablaMalignos(:,1), TestTablaMalignos2(:,2:10)/TestNormFacm];
%normalizamos los valores benignos las matrices de test
TestNormFacb = sum(TestTablaBenignos2(:,2));
TestConteoBenignosNorm = [TestTablaBenignos(:,1), TestTablaBenignos2(:,2:10)/TestNormFacb];

%desde aqui se comienza a calcular la probabilidad de que el tumor sea
%maligno o benigno con una funcion aparte que regresa un vector con la
%clase que se predice

%prediccion de la matriz de malignos de test
PrediccionClaseM = PrediccionClase(TestMUV, TestConteoMalignosNorm, TestConteoBenignosNorm);
MapaPredM = TestMUV(:, 11) == PrediccionClaseM;
%porcentaje de aciertos malignos
%presicion
porcentajeM = 100*(sum(MapaPredM,1)/ size(TestMUV,1));
%prediccion de la matriz de benignos de test
PrediccionClaseB = PrediccionClase(TestBUV, TestConteoMalignosNorm, TestConteoBenignosNorm);
MapaPredB = TestBUV(:, 11) == PrediccionClaseB;
%porcentaje de aciertos benignos
%recall
porcentajeB = 100*(sum(MapaPredB,1)/ size(TestBUV,1));

%prediccion de la matriz Test con ambas clases
PrediccionClases = PrediccionClase(Test, TestConteoMalignosNorm, TestConteoBenignosNorm);
%mapa de comparacion de la prediccion y el valor real
MapaPred = Test(:, 11) == PrediccionClases;
%porcentaje de aciertos de predicciones en la matriz Test
porcentaje = 100* (sum(MapaPred,1)/size(Test,1)); 

true_positive = 0; % la prediccion es maligno 4 y el valor real es maligno 4
true_negative = 0; % la prediccion es benigno 2 y el valor real es benigno 2
false_positive = 0; % la prediccion es maligno 4 y el valor real es benigno 2
false_negative = 0; % la prediccion es benigno 2 y el valor real es maligno 4
% en este for se  cálcula la cantidad de positivos y negativos
for renglon=1: size(Test(:, 11))
    if Test(renglon,11) == 4 && PrediccionClases(renglon,1) == 4
        true_positive = true_positive + 1;
    elseif Test(renglon,11) == 4 && PrediccionClases(renglon,1) == 2
        false_negative = false_negative + 1;
    elseif Test(renglon,11) == 2 && PrediccionClases(renglon,1) == 2
        true_negative = true_negative + 1;
    elseif Test(renglon,11) == 2 && PrediccionClases(renglon,1) == 4
        false_positive = false_positive + 1;
    end
end
% aquí se cálculan la precisión, recall y Fscore
precision = true_positive / (true_positive + false_positive);
recall = true_positive / (true_positive + false_negative);
fscore = (2 * precision * recall) / (precision + recall);





