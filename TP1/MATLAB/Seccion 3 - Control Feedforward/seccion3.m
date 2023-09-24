%% 1.
%{
Identificar la funci�n transferencia Gd por el m�todo de Cohen-Coon
(salto escal�n de magnitud +4% en Fi), utilizando la subrutina Cohen_Coon.m.
Ajustar y validar el modelo.
%}
%{
Tiempo Muerto (tita) = 10.1324
Tau = 73.5999
Ganancia (K) = -0.6107
%}
tiempo_muerto = 10.1324;
tau = 90;
k = -0.6109;

sim('transferencia_Gd_lazo_abierto')

%Plot comparativo: Respuesta Real vs Modelo
plot(...
    C_E_real.time, C_E_real.signals.values,...
    C_E_modelo.time, C_E_modelo.signals.values...
)
legend('Real', 'Modelo')
grid on

%% 2.
%{
A partir de las funciones transferencias Gp y Gd obtenidas, dise�ar el
correspondiente controlador Feedforward (Gff) para la perturbaci�n Fi.
%}
%% 3.
%{
Presentar una gr�fica donde se superponga la evoluci�n temporal de CE cuando
se produce una perturbaci�n de +1% en Fi para:
3.1.- El mejor PID obtenido en la secci�n 2.
3.2.- El control combinado Feedback + Feedforward (Figura 7), utilizando el
mismo controlador del �tem 3.1 como controlador Feedback.
%}
%% 4.
%{
Completar el punto anterior (�tem 3) presentando una gr�fica comparativa 
con la evoluci�n temporal de la variable manipulada Fh.
%}

% Gff = - Gd / Gp
tau_p = 100;
tiempo_muerto_p = 21.8;
kp = 0.2081;
gamma = tiempo_muerto_p - tiempo_muerto;

sim('control_feedforward');
sim('control_solo_feedback');

subplot(2,1,1), plot(...
    C_E_real.time, C_E_real.signals.values,...
    C_E_sin_FF.time, C_E_sin_FF.signals.values...
)
legend('CON Feedforward', 'SIN Feedforward')
grid on
subplot(2,1,2), plot(...
    F_h_con_FF.time, F_h_con_FF.signals.values,...
    F_h_sin_FF.time, F_h_sin_FF.signals.values...
)
legend('CON Feedforward', 'SIN Feedforward')
grid on


%% 5.
%{
Calcular el �ndice IAE para cuantificar las diferencias entre las dos
estrategias de control.
%}

%% 6. Conclusiones generales.