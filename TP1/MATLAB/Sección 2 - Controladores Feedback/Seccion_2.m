%% Entradas del sistema en el punto de equilibrio
Ci0=1.1367;   % [mol/m3] Concentración de componente entrante
Ti0=298;  % [ºK] Temperatura de componente entrante
Fi0=1; % [m3/seg] Flujo de componente entrante
Th0=473;      %[ºK] Temperatura del refrigerante entrante

% Variables manipuladas del sistema en el punto de equilibrio
Fh0=0.8946; %[m3/seg] Caudal del refrigerante
Ce0=0.543; % [mol/m3] Concentración de componente saliente
Ap0=49.978; % Porcentaje de apertura 

% Salida con el sistema en el punto de equilibrio
TJ0= 176.800605; % [ºK] Temperatura de la camisa

% Perturbaciones
DFh=Fh0*0.01; %[ m3/seg] Caudal de perturbación

% Puntos de operación
T=323;
Ce=0.543;
Tj=408.9494;
%% Modelado de la planta

% Valores preliminares:
%   - tpo muerto(tita) 18.7500
%   - tau 141.1618
%   - ganancia 0.2081

% Valores ajustados:
%   - tita 21.8
%   - tau 100
%   - ganancia 0.2081

figure(1);
plot(CC_aj.time,CC_aj.signals.values+Ce0,C_E.time,C_E.signals.values);
legend('Salida aproximada','Salida real');

grid on;

%% Controlador Cohen-Coon
% P
% IAE:  1.644
% ISE:  0.006064
% ITAE: 504.1
KcP_CC = 20.8233;

% PI
% IAE:  0.7334
% ISE:  0.004524
% ITAE: 57.07
KcPI_CC = 17.6998;
TaoiPI_CC = 54.9107; 
KiPI_CC = KcPI_CC/TaoiPI_CC;

% PID
% IAE:  0.5698
% ISE:  0.003689
% ITAE: 32.55
KcPID_CC   = 26.8300;
TaoiPID_CC = 55.8333;
TaodPID_CC = 8.6957;
KiPID_CC   = KcPID_CC/TaoiPID_CC;
KdPID_CC   = KcPID_CC*TaodPID_CC;


% Ploteo de comparación de controladores PID
% correr el archivo 'Planta_controlada_cc'
figure(2);
plot(control_cc_p.time,control_cc_p.signals.values,'r',...
    control_cc_pi.time,control_cc_pi.signals.values,'b',...
    control_cc_pid.time,control_cc_pid.signals.values,'g', 'LineWidth',1.5);
legend('P','PI', 'PID');
title('Planta + controlador CC');
xlabel('Tiempo [s]');
ylabel('CE');
xlim([0 500]);
grid on;

%% Controlador ZN
% P
% IAE:  1.941
% ISE:  0.007486
% ITAE: 602.4
KcP_ZN = 16.6250;

% PI
% IAE:  0.6214
% ISE:  0.00418
% ITAE: 37.91
KcPI_ZN   = 14.9625;
TaoiPI_ZN = 76.2500;
KiPI_ZN   = KcPI_ZN/TaoiPI_ZN;

% PID
% IAE:  0.6971
% ISE:  0.004089
% ITAE: 55.12
KcPID_ZN   = 19.9500;
TaoiPID_ZN = 45.7500;
TaodPID_ZN = 11.4375;
KiPID_ZN   = KcPID_ZN/TaoiPID_ZN;
KdPID_ZN   = KcPID_ZN*TaodPID_ZN;

figure(3);
plot(control_zn_p.time,control_zn_p.signals.values,'r',...
    control_zn_pi.time,control_zn_pi.signals.values,'b',...
    control_zn_pid.time,control_zn_pid.signals.values,'g', 'LineWidth',1.5);
legend('P','PI', 'PID');
title('Planta + controlador ZN');
xlabel('Tiempo [s]');
ylabel('CE');
xlim([0 500]);
grid on;

%% Controlador IMC 0.5*100
% PI
% IAE:  0.6472
% ISE:  0.004877
% ITAE: 35
KcPI_IMC = 9.6108;
TaoiPI_IMC = 100;
KiPI_IMC   = KcPI_IMC/TaoiPI_IMC;

% PI-Mejorado
% IAE:  0.5991
% ISE:  0.004615
% ITAE: 31.03
KcPIM_IMC   = 10.8121;
TaoiPIM_IMC = 112.5000;
KiPIM_IMC   = KcPIM_IMC/TaoiPIM_IMC;

% PID
% IAE:  0.84
% ISE:  0.005816
% ITAE: 56.74
KcPID_IMC   = 7.2081;
TaoiPID_IMC = 112.5000;
TaodPID_IMC = 11.1111;
KiPID_IMC   = KcPID_IMC/TaoiPID_IMC;
KdPID_IMC   = KcPID_IMC*TaodPID_IMC;

figure(4);
plot(control_imc_pi.time,control_imc_pi.signals.values,'r',...
    control_imc_pim.time,control_imc_pim.signals.values,'b',...
    control_imc_pid.time,control_imc_pid.signals.values,'g', 'LineWidth',1.5);
legend('PI','PI-M', 'PID');
title('Planta + controlador IMC');
xlabel('Tiempo [s]');
ylabel('CE');
xlim([0 500]);
grid on;

%% Comparación de los mejores controladores (menor IAE)
figure(5);
plot(control_cc_pid.time,control_cc_pid.signals.values,'r',...
    control_zn_pi.time,control_zn_pi.signals.values,'b',...
    control_imc_pim.time,control_imc_pim.signals.values,'g', 'LineWidth',1.5);
legend('PID CC','PI ZN', 'PI-M IMC');
title('Respuesta al escalón de los mejores controladores');
xlabel('Tiempo [s]');
ylabel('CE');
xlim([0 500]);
grid on;

%% -------------- VARIOS -----------------------------------

%% Ploteo de comparación de controladores PID
% correr el archivo 'respuesta_de_controladores.mat'
figure(5);
plot(controlada_cc.time,controlada_cc.signals.values,...
    controlada_zn.time,controlada_zn.signals.values,...
    controlada_imc1.time,controlada_imc1.signals.values,...
    controlada_imc2.time,controlada_imc2.signals.values,...
    controlada_imc3.time,controlada_imc3.signals.values);
legend('CC','ZN', 'IMC1', 'IMC2', 'IMC3');
title('Respuesta al escalón de la planta controlada');
grid on;
%% Controlador Cohen-Coon
%{
Programa para el calculo de los parametros de los controladores por el 
metodo de Cohen-Coon
 
Ingresar la ganancia estatica del sistema 0.2081
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 25
 
Controlador P
KcP_CC = 20.8233

Controlador PI
KcPI_CC = 17.6998
TaoiPI_CC = 54.9107

Controlador PID
KcPID_CC = 26.8300
TaoiPID_CC = 55.8333
TaodPID_CC = 8.6957
%}

%% Controlador ZN
% período último: 91,5
% k_úlltimo: 33.25
figure(5);
plot(Gu_Pu.time,Gu_Pu.signals.values);
grid on;

%{
ZN_Controladores
Programa para el calculo de los parametros de los controladores por el 
metodo de Ziegler-Nichols
 
Ingresar la ganancia ultima del sistema 33.25
Ingresar el periodo ultimo del sistema 91.5
 
Controlador P
KcP = 16.6250

Controlador PI
KcPI = N14.9625
TaoiPI = 76.2500

Controlador PID
KcPID = 19.9500
TaoiPID = 45.7500
TaodPID = 11.4375

%}

%% Controlador IMC
%{
IMC_Controladores
Programa para el calculo de los parametros de los controladores por el metodo de IMC
 
Ingresar la ganancia estatica del sistema 0.2081
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 25
Ingresar el valor del parametro ajustable del fltro 0.5*100
 
Controlador PI
KcPI = 9.6108
TaoiPI = 100

Controlador PI-"Mejorado"
KcPI_M = 10.8121
TaoiPI_M = 112.5000

Controlador PID
KcPID = 7.2081
TaoiPID = 112.5000
TaodPID = 11.1111

IMC_Controladores
Programa para el calculo de los parametros de los controladores por el metodo de IMC
 
Ingresar la ganancia estatica del sistema 0.2081
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 25
Ingresar el valor del parametro ajustable del fltro 100
 
Controlador PI
KcPI = 4.8054
TaoiPI = 100

Controlador PI-"Mejorado"
KcPI_M = 5.4061
TaoiPI_M = 112.5000

Controlador PID
KcPID = 4.3248
TaoiPID = 112.5000
TaodPID = 11.1111

IMC_Controladores
Programa para el calculo de los parametros de los controladores por el metodo de IMC
 
Ingresar la ganancia estatica del sistema 0.2081
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 25
Ingresar el valor del parametro ajustable del fltro 0.3*100
 
Controlador PI
KcPI = 16.0179
TaoiPI = 100

Controlador PI-"Mejorado"
KcPI_M = 18.0202
TaoiPI_M = 112.5000

Controlador PID
KcPID = 9.8292
TaoiPID = 112.5000
TaodPID = 11.1111
%}