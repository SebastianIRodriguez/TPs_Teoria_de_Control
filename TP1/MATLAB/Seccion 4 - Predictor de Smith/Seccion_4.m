%% CONSIGNA SECCION 4 - PREDICTOR DE SMITH
%% 1.
%{
A partir de la funci�n transferencia Gp(s) obtenida en la secci�n 2
(ajustada y validada), dise�ar el correspondiente compensador de tiempo muerto.
%}

%% 2.
%{
Dise�ar el controlador PI correspondiente al esquema con compensador 
de Smith utilizando el m�todo IMC. Tener en cuenta que deber� considerarse
tiempo muerto nulo para el dise�o. Adem�s, recordar que es posible utilizar
un ajuste m�s agresivo del controlador.
%}

%{
IMC_Controladores
Programa para el calculo de los parametros de los controladores por el metodo de IMC
 
Ingresar la ganancia estatica del sistema 0.2081
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 0
Ingresar el valor del parametro ajustable del fltro 20
 
Controlador PI
KcPI = 24.0269
TaoiPI = 100

Controlador PI-"Mejorado"
KcPI_M = 24.0269
TaoiPI_M = 100

Controlador PID
KcPID = 24.0269
TaoiPID = 100
TaodPID = 0
%}
Fh0=0.8946;
KcPI = 24.0269;
TaoiPI = 100;

sim('Predictor_de_smith.slx')

figure(9);
plot(CE_SMITH.time,CE_SMITH.signals.values,'LineSmoothing','on');
grid on;

%% 3.
%{
Presentar una gr�fica donde se superponga la evoluci�n temporal de CE 
cuando se produce un salto escal�n del +2% en el setpoint para:
3.1.- El controlador PI obtenido en la secci�n 2 con el m�todo IMC.
3.2.- El control con compensador de tiempo muerto (puntos 1 a 2).
%}
%Controlador PI CON predictor de Smith
Kc_Smith = 24.0269;
Tau_Smith = 100;

%Controlador PI SIN predictor de Smith
Kc_Normal = 9.6108;
Tau_Normal = 100;

sim('Predictor_de_smith_con_planta.slx')
sim('solo_feedback.slx')
plot(...
    CE_SMITH.time, CE_SMITH.signals.values,'r',...
    CE_NORMAL.time, CE_NORMAL.signals.values,'b',...
    'LineWidth', 1.5,...
    'LineSmoothing','on'...
);
title('Evolucion de Ce para un escal�n del 2% en el Set Point')
ylabel('Ce [mol/m3]')
xlabel('Tiempo [s]')
xlim([0 350])
legend('CON predictor', 'SIN Predictor')
grid on;
%% 4A

%Controlador PI CON predictor de Smith
Kc_Smith = 240;
Tau_Smith = 100;

%Controlador PI SIN predictor de Smith
Kc_Normal = 80;
Tau_Normal = 100;

sim('Predictor_de_smith_con_planta.slx')
sim('solo_feedback.slx')
plot(...
    CE_SMITH.time, CE_SMITH.signals.values,'r',...
    CE_NORMAL.time, CE_NORMAL.signals.values,'b',...
    'LineWidth', 1.5,...
    'LineSmoothing','on'...
);
title('Evolucion de Ce para un escal�n del 2% en el Set Point')
ylabel('Ce [mol/m3]')
xlabel('Tiempo [s]')
%xlim([0 350])
legend('CON predictor', 'SIN Predictor')
grid on;
%% 4B

%Controlador PI CON predictor de Smith
Kc_Smith = 240;
Tau_Smith = 100;

%Controlador PI SIN predictor de Smith
Kc_Normal = 20;
Tau_Normal = 100;

sim('Predictor_de_smith_con_planta.slx')
sim('solo_feedback.slx')
plot(...
    CE_SMITH.time, CE_SMITH.signals.values,'r',...
    CE_NORMAL.time, CE_NORMAL.signals.values,'b',...
    'LineWidth', 1.5,...
    'LineSmoothing','on'...
);
title('Evolucion de Ce para un escal�n del 2% en el Set Point')
ylabel('Ce [mol/m3]')
xlabel('Tiempo [s]')
xlim([0 350])
legend('CON predictor - Kc = 240', 'SIN Predictor - Kc = 20')
grid on;
%% 4.
%{
Analizar el comportamiento de CE ante un aumento de la ganancia del 
controlador PI para un esquema con y sin predictor de Smith.
%}
%Controlador PI CON predictor de Smith
Kc_Smith = 24.0269;
Tau_Smith = 100;

%Controlador PI SIN predictor de Smith
Kc_Normal = 9.6108;
Tau_Normal = 100;

save('backup_workspace');
[ce_smith, ce_normal] = simular_sistemas();
[ce_smith_ganancia, ce_normal_ganancia] = simular_sistemas();

plot(...
    ce_smith.time, ce_smith.signals.values,'--red',...
    ce_smith_ganancia.time, ce_smith_ganancia.signals.values,'red',...
    ce_normal.time, ce_normal.signals.values,'--blue',...
    ce_normal_ganancia.time, ce_normal_ganancia.signals.values,'blue',...
    'LineWidth', 1.25...
);
legend(...
    'CON predictor',...
    'CON Predictor - Ganancia 5000',...
    'SIN Predictor',...
    'SIN Predictor - Ganancia 30'...
)
title('Evolucion de Ce para un escal�n del 2% en el Set Point')
ylabel('Ce [mol/m3]')
xlabel('Tiempo [s]')
grid on;
%% 5.
%{
Calcular el �ndice IAE para cuantificar las diferencias entre las dos
estrategias de control.
%}

%% 6.
% Conclusiones generales




