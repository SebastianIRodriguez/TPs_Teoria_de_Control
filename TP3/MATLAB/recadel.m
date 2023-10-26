function [gz]=recadel(gs,T)
% Calcula G(z) usando la regla rectangular por adelanto. 
% 
% gs -> debe ser un sistema continuo en formato zpk.
% T  -> intervalo de muestreo.

gz=zpk(bilin(ss(gs),1,'FwdRec',T));


