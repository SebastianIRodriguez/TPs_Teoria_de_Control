%% Modelado de planta + valvula
%Parametros de funcion de transferencia: tpo muerto(tita), tau y ganancia (K)
%Parametros = 22.8958  142.3164    0.0039

Ap0=50;
tita_planta_ap = 30;
tau_planta_ap = 103;
k_planta_ap = 0.0039;


figure(10);
plot(C_E_AP.time,C_E_AP.signals.values,'r',...
    C_E_AP_modelada.time,Ce0+C_E_AP_modelada.signals.values,'b');
grid on;
title('Planta real+válvula vs modelo');
legend('Planta + válvula','Modelo');