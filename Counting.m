function [TablaA] = Counting(BUV, A )
%removemos la primer y ultima fila(ID y Clase)
BUV(:,11) = [];
BUV(:,1) = [];
SA=size(A,1);
%creamos una tabla en ceros para llenar las sumas
Freqs = zeros(size(A,1),size(BUV,2));
% encontramos las frecuencias de todos los valores en la matriz train con
% un loop for
for c=1:SA
    mapa=BUV==A(c,1);
    temp = sum(mapa);    
    Freqs(c,:) = temp;
    
end 
TablaA = [A, Freqs];
end

