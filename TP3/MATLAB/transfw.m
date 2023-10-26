function [gw]=transfw(gz)
% Calcula G(w) (Transformada W) de la 
% funcion transferencia G(z).
% 
% gz -> debe ser un sistema discreto en formato zpk.
% gw contiene la transformada W en formato zpk, pero expresada en la variable s.

gw=zpk(bilin(ss(gz),-1,'Tustin',get(gz,'Ts')));


