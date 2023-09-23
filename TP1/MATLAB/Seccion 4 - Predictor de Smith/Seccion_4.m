%% CONSIGNA SECCION 4 - PREDICTOR DE SMITH
%% 1.
%{
A partir de la función transferencia Gp(s) obtenida en la sección 2
(ajustada y validada), diseñar el correspondiente compensador de tiempo muerto.
%}

%% 2.
%{
Diseñar el controlador PI correspondiente al esquema con compensador 
de Smith utilizando el método IMC. Tener en cuenta que deberá considerarse
tiempo muerto nulo para el diseño. Además, recordar que es posible utilizar
un ajuste más agresivo del controlador.
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

figure(9);
plot(CE_SMITH.time,CE_SMITH.signals.values);
grid on;

%% 3.
%{
Presentar una gráfica donde se superponga la evolución temporal de CE 
cuando se produce un salto escalón del +2% en el setpoint para:
3.1.- El controlador PI obtenido en la sección 2 con el método IMC.
3.2.- El control con compensador de tiempo muerto (puntos 1 a 2).
%}
%Controlador PI CON predictor de Smith
Kc_Smith = 24.0269;
Tau_Smith = 100;

%Controlador PI SIN predictor de Smith
Kc_Normal = 9.6108;
Tau_Normal = 100;

[ce_smith, ce_normal] = simular_sistemas(Kc_Smith, Tau_Smith, Kc_Normal, Tau_Normal, Fh0);

plot(...
    ce_smith.time, ce_smith.signals.values,'r',...
    ce_normal.time, ce_normal.signals.values,'b'...    
);
legend('CON predictor', 'SIN Predictor')
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

[ce_smith, ce_normal] = simular_sistemas(Kc_Smith, Tau_Smith, Kc_Normal, Tau_Normal, Fh0);
[ce_smith_ganancia, ce_normal_ganancia] = simular_sistemas(50, Tau_Smith, 30, Tau_Normal, Fh0);

plot(...
    ce_smith.time, ce_smith.signals.values,'red',...
    ce_smith_ganancia.time, ce_smith_ganancia.signals.values,'green',...
    ce_normal.time, ce_normal.signals.values,'magenta',...
    ce_normal_ganancia.time, ce_normal_ganancia.signals.values,'blue'...    
);
legend(...
    'CON predictor',...
    'CON Predictor - Ganancia 50',...
    'SIN Predictor',...
    'SIN Predictor - Ganancia 30'...
)
grid on;
%% 5.
%{
Calcular el índice IAE para cuantificar las diferencias entre las dos
estrategias de control.
%}

%% 6.
% Conclusiones generales




