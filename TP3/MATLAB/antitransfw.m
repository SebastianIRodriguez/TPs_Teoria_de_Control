function [gz]=antitransfw(gw,Ts)
% Calcula la funcion transferencia G(z) a partir de la 
% transformada W G(w).
% 
% gw contiene la transformada W en formato zpk, pero expresada en la variable s.
% gz -> sistema discreto en formato zpk.

gz=zpk(bilin(ss(gw),1,'Tustin',Ts));
