%% 1.
%{
Identificar la función transferencia Gd por el método de Cohen-Coon
(salto escalón de magnitud +4% en Fi), utilizando la subrutina Cohen_Coon.m.
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
    C_E_real.time, C_E_real.signals.values,'r',...
    C_E_modelo.time, C_E_modelo.signals.values,'b',...
    'LineWidth',1.5...
)
title('Evolucion de Ce para un escalón del 1% en Fi')
legend('Real', 'Modelo')
ylabel('Ce [mol/m3]')
xlabel('Tiempo [s]')
xlim([0 600])
grid on

%% 2.
%{
A partir de las funciones transferencias Gp y Gd obtenidas, diseñar el
correspondiente controlador Feedforward (Gff) para la perturbación Fi.
%}
%% 3.
%{
Presentar una gráfica donde se superponga la evolución temporal de CE cuando
se produce una perturbación de +1% en Fi para:
3.1.- El mejor PID obtenido en la sección 2.
3.2.- El control combinado Feedback + Feedforward (Figura 7), utilizando el
mismo controlador del ítem 3.1 como controlador Feedback.
%}
%% 4.
%{
Completar el punto anterior (ítem 3) presentando una gráfica comparativa 
con la evolución temporal de la variable manipulada Fh.
%}

% Gff = - Gd / Gp
tau_p = 100;
tiempo_muerto_p = 21.8;
kp = 0.2081;
gamma = tiempo_muerto_p - tiempo_muerto;

% Controlador Cohen-coon
KcPID_CC   = 26.8300;
TaoiPID_CC = 55.8333;
TaodPID_CC = 8.6957;
KiPID_CC   = KcPID_CC/TaoiPID_CC;
KdPID_CC   = KcPID_CC*TaodPID_CC;


sim('control_feedforward');
sim('control_solo_feedback');
figure(3)
subplot(2,1,1), plot(...
    C_E_real.time, C_E_real.signals.values,'r',...
    C_E_sin_FF.time, C_E_sin_FF.signals.values,'b',...
    'LineWidth',1.5...
)
ylabel('Ce [mol/m3]')
xlabel('Tiempo [s]')
title('Variable Controlada (Ce)')
legend('CON Feedforward', 'SIN Feedforward')
grid on
subplot(2,1,2), plot(...
    F_h_con_FF.time, F_h_con_FF.signals.values,'r',...
    F_h_sin_FF.time, F_h_sin_FF.signals.values,'b',...
    'LineWidth',1.5...
)
title('Variable Manipulada (Fh)')
legend('CON Feedforward', 'SIN Feedforward')
ylabel('Fh [m3/seg]')
xlabel('Tiempo [s]')
grid on


%% 5.
%{
Calcular el índice IAE para cuantificar las diferencias entre las dos
estrategias de control.
%}

%% 6. Conclusiones generales.
