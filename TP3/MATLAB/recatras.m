function [gz]=recatras(gs,T)
% Calcula G(z) usando la regla rectangular por atraso. 
% 
% gs -> debe ser un sistema continuo en formato zpk.
% T  -> intervalo de muestreo.

gz=zpk(bilin(ss(gs),1,'BwdRec',T));


