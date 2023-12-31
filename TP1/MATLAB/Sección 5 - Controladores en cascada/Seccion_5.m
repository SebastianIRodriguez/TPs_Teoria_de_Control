%% Entradas del sistema en el punto de equilibrio
Ci0=1.1367;   % [mol/m3] Concentraci�n de componente entrante
Ti0=298;  % [�K] Temperatura de componente entrante
Fi0=1; % [m3/seg] Flujo de componente entrante
Th0=473;      %[�K] Temperatura del refrigerante entrante

% Variables manipuladas del sistema en el punto de equilibrio
Fh0=0.8946; %[m3/seg] Caudal del refrigerante
Ce0=0.543; % [mol/m3] Concentraci�n de componente saliente
Ap0=49.978; % Porcentaje de apertura 

% Salida con el sistema en el punto de equilibrio
TJ0= 176.800605; % [�K] Temperatura de la camisa

% Perturbaciones
DFh=Fh0*0.01; %[ m3/seg] Caudal de perturbaci�n

% Puntos de operaci�n
T=323;
Ce=0.543;
Tj=408.9494;

load('data');
%% 1) PID del sistema v�lvula reactor
k_ap = 0.003731;
tau_ap = 100;
tita_ap = 30;
sim('Modelado_val_react');

figure(1);
plot(CE_AP.time,CE_AP.signals.values,CE_AP_mod.time,CE_AP_mod.signals.values);
title('Sistema v�lvula-reactor real y modelado frente a escal�n de +4% SP(Ap)');
legend('Real','Modelada');
xlabel('Tiempo [s]');
ylabel('Fh');
grid on;

%{
Ingresar el vector de tiempos de la simulacion SP_AP.time
Ingresar el vector de la respuesta de la variable en estudio CE_AP.signals.values
Ingresar el vector de la variable excitada SP_AP.signals.values
Ingresar el tiempo en que se excita la variable de entrada 10
 
Parametros de funcion de transferencia: tpo muerto(tita), tau y ganancia (K)

Parametros =

   23.0783  141.9059    0.0037
%}.

%Dise�o del controlador PID

% Cohen-coon (el mejor
% IAE:  0.6677
% ISE:  0.004472
% ITAE: 41.74
% A DFH
% IAE:  0.02631
% ISE:  6.547e-6
% ITAE: 2.205
Kc_CC_ap   = 1.2582e+03;
Taoi_CC_ap = 65.8442;
Taod_CC_ap = 10.3448;
Ki_CC_ap   = Kc_CC_ap/Taoi_CC_ap;
Kd_CC_ap   = Kc_CC_ap*Taod_CC_ap;

% ZN
% IAE:  0.82
% ISE:  0.005052
% ITAE: 70.44
% A DFH
% IAE:  0.03516
% ISE:  9.225e-6
% ITAE: 3.568
Kc_ZN_ap   = 947.1;
Taoi_ZN_ap = 54.2667;
Taod_ZN_ap = 13.5667;
Ki_ZN_ap   = Kc_ZN_ap/Taoi_ZN_ap;
Kd_ZN_ap   = Kc_ZN_ap*Taod_ZN_ap;

% PI IMC
% IAE:  0.9279
% ISE:  0.006765
% ITAE: 67.55
% A DFH
% IAE:  0.1498
% ISE:  6.786e-5
% ITAE: 29.37
Kc_IMC_ap   = 385.2854;
Taoi_IMC_ap = 115;
Taod_IMC_ap = 13.0435;
Ki_IMC_ap   = Kc_IMC_ap/Taoi_IMC_ap;
Kd_IMC_ap   = Kc_IMC_ap*Taod_IMC_ap;

%{
Cohen-coon
Ingresar la ganancia estatica del sistema 0.003731
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 30
 
Controlador PID
KcPID = 1.2582e+03
TaoiPID = 65.8442
TaodPID = 10.3448
%}

%{
ZN

k_ult = 1578.5;
plot(Gu_Pu.time,Gu_Pu.signals.values)
grid on;
ginput;
T_ult = 722.6842 - 614.1508;

Ingresar la ganancia ultima del sistema 1578.5
Ingresar el periodo ultimo del sistema T_ult
 
Controlador PID
KcPID = 947.1000
TaoiPID = 54.2667
TaodPID = 13.5667
%}

%{
IMC 
Ingresar la ganancia estatica del sistema 0.003731
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 30
Ingresar el valor del parametro ajustable del fltro 50
 
Controlador PID
KcPID = 385.2854
TaoiPID = 115
TaodPID = 13.0435
%}
%% 2) Modelado de la v�lvula
k_v = 0.0179;
tau_v = 3.5;
tita_v = 0.9993;
sim('Modelado_valvula');
figure(2);
plot(F_h.time,F_h.signals.values,F_h_modelo.time,F_h_modelo.signals.values);
title('V�lvula real vs modelada frente a escal�n del 4% en %Ap');
legend('Real','Modelada');
xlabel('Tiempo [s]');
ylabel('Fh');
grid on;
%{
Cohen_Coon
Programa que calcula los parametros de la funcion de transferencia a partir del metodo
de Cohen - Coon.
 
Ingresar el vector de tiempos de la simulacion Ap.time
Ingresar el vector de la respuesta de la variable en estudio F_h.signals.values
Ingresar el vector de la variable excitada Ap.signals.values
Ingresar el tiempo en que se excita la variable de entrada 10
 
Parametros de funcion de transferencia: tpo muerto(tita), tau y ganancia (K)

Parametros =

    0.9993    4.0244    0.0179
%}


%% 3) Dise�o del controlador PI para la v�lvula

% Cohen-coon
% IAE:  0.6622
% ISE:  0.0006819
% ITAE: 0.909
% A DFH
% IAE:  0.03311
% ISE:  0.0001705
% ITAE: 0.04545
Kc_CC_v   = 180.7564;
Taoi_CC_v = 2.0961;
Ki_CC_v   = Kc_CC_v/Taoi_CC_v;

% ZN
% IAE:  0.04372
% ISE:  0.0005103
% ITAE: 0.5283
% A DFH
% IAE:  0.02186
% ISE:  0.0001276
% ITAE: 0.241
Kc_ZN_v   = 155.1600;
Taoi_ZN_v = 3.0087;
Ki_ZN_v   = Kc_ZN_v/Taoi_ZN_v;

% PI IMC
% IAE:  0.03772
% ISE:  0.0005132
% ITAE: 0.4293
% A DFH
% IAE:  0.01886
% ISE:  0.0001283
% ITAE: 0.2147
Kc_IMC_v   = 111.7318;
Taoi_IMC_v = 3.5000;
Ki_IMC_v   = Kc_IMC_v/Taoi_IMC_v;

% PI "mejorado" IMC
% IAE:  0.03769
% ISE:  0.0004928
% ITAE: 0.4403
% A DFH
% IAE:  0.01885
% ISE:  0.0001232
% ITAE: 0.2202
KcPIM_IMC_v   = 127.6824;
TaoiPIM_IMC_v = 3.9996;
KiPIM_IMC_v   = KcPIM_IMC_v/TaoiPIM_IMC_v;

figure(3);
amp = Fh0*0.02;
cota_sup = amp*0.02+Fh0*1.02;
cota_inf = -amp*0.02+Fh0*1.02;
up_limit = ones(601) * cota_sup;
low_limit = ones(601) * cota_inf;
load('Resultados_control_valvula');
plot(Fh_v_CC.time,Fh_v_CC.signals.values,...
    Fh_v_ZN.time,Fh_v_ZN.signals.values,...
    Fh_v_IMC.time,Fh_v_IMC.signals.values,...
    Fh_v_IMC_m.time,Fh_v_IMC_m.signals.values);
hold on;
figure(3);
%plot(Fh_v_CC_pert.time,up_limit,'m:',...
%    Fh_v_CC_pert.time,low_limit,'m:');
grid on;
title('Controles vs escal�n SP +2%');
legend('CC','ZN','IMC','IMCm');
xlim([0 40]);
xlabel('Tiempo [s]');
ylabel('Fh');

figure(4);
amp = Fh0*0.01;
cota_sup = amp*0.02+Fh0;
cota_inf = -amp*0.02+Fh0;
up_limit = ones(601) * cota_sup;
low_limit = ones(601) * cota_inf;
plot(Fh_v_CC_pert.time,Fh_v_CC_pert.signals.values,'r',...
    Fh_v_ZN_pert.time,Fh_v_ZN_pert.signals.values,'b',...
    Fh_v_IMC_pert.time,Fh_v_IMC_pert.signals.values,'g',...
    Fh_v_IMC_m_pert.time,Fh_v_IMC_m_pert.signals.values,'c');
hold on;
figure(4);
%plot(Fh_v_CC_pert.time,up_limit,'m:',...
  %  Fh_v_CC_pert.time,low_limit,'m:');
grid on;
title('Controles vs escal�n Dfh +1% de Fh0');
legend('CC','ZN','IMC','IMCm');
xlim([0 40]);
xlabel('Tiempo [s]');
ylabel('Fh');

%{
Cohen-coon
Ingresar la ganancia estatica del sistema 0.0179
Ingresar la constante de tiempo del sistema 3.5
Ingresar el tiempo muerto del sistema 0.9993
 
Controlador P
KcP = 214.2897

Controlador PI
KcPI = 180.7564
TaoiPI = 2.0961

Controlador PID
KcPID = 274.8567
TaoiPID = 2.2042
TaodPID = 0.3454
%}

%{
ZN:
K_ult = 344.8;
T_ult = 3.6104;
plot(Gu_Pu.time,Gu_Pu.signals.values)
grid on;
ginput;
T �ltimo = 27.7832 - 24.1728;

Ingresar la ganancia ultima del sistema K_ult
Ingresar el periodo ultimo del sistema T_ult
 
Controlador P
KcP = 172.4000

Controlador PI
KcPI = 155.1600
TaoiPI = 3.0087

Controlador PID
KcPID = 206.8800
TaoiPID = 1.8052
TaodPID = 0.4513
%}

%{
IMC
Ingresar la ganancia estatica del sistema 0.0179
Ingresar la constante de tiempo del sistema 3.5
Ingresar el tiempo muerto del sistema 0.9993
Ingresar el valor del parametro ajustable del fltro 0.5*3.5
 
Controlador PI
KcPI = 111.7318
TaoiPI = 3.5000

Controlador PI-"Mejorado"
KcPI_M = 127.6824
TaoiPI_M = 3.9996

Controlador PID
KcPID = 81.2731
TaoiPID = 3.9996
TaodPID = 0.4372
%}

%% 4) Transferencia de CE(SP)

k_pl_v = 0.2084;
tau_pl_v = 100;  %100
tita_pl_v = 28; %25
sim('Modelado_cascada_val_planta');

figure(5);
plot(CE_mod_cascada_real.time,CE_mod_cascada_real.signals.values,...
    CE_mod_cascada_modelada.time,CE_mod_cascada_modelada.signals.values);
title('Cascada real vs modelada frente a escal�n del 4% en el SP de Fh');
legend('Real','Modelada');
xlabel('Tiempo [s]');
ylabel('CE');
grid on;
%{
Ingresar el vector de tiempos de la simulacion SP_mod_cascada.time
Ingresar el vector de la respuesta de la variable en estudio CE_mod_cascada.signals.values
Ingresar el vector de la variable excitada SP_mod_cascada.signals.values
Ingresar el tiempo en que se excita la variable de entrada 10
 
Parametros de funcion de transferencia: tpo muerto(tita), tau y ganancia (K)

Parametros =

   35.7784   30.4956    0.2081
%}

%% 5 Dise�o de PID


%{
Ingresar la ganancia estatica del sistema 0.2084
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 25
 
Controlador PID
KcPID = 26.7914
TaoiPID = 55.8333
TaodPID = 8.6957
%}

%Controlador PID
% IAE:  0.6196
% ISE:  0.0004166
% ITAE: 36.05
% A DFH
% IAE:  0.01867
% ISE:  1.94e-8
% ITAE: 0.448
Kc_PID = 26.7914;
TaoiPID = 55.8333;
TaodPID = 8.6957;
Ki_PID   = Kc_PID/TaoiPID;
Kd_PID   = Kc_PID * TaodPID;

load('Resultados_prueba_control_cascada');

%% 6,7) Comparaci�n de los m�todos  frente a Dfh
% La perturbaci�n del principio parece ser producida por un leve error 
% en los par�metros de equilibrio, por eso meto el escal�n pasado ese
% transitorio

% Control de lazo simple
% PARA SALTO EN SP 
% IAE:  0.669
% ISE:  0.00448
% ITAE: 235.6
% PARA SALTO EN DFH
% IAE:  0.02693
% ISE:  6.682e-6
% ITAE: 9.847

% Control en cascada
% PARA SALTO EN SP 
% IAE:  0.6196
% ISE:  0.004166
% ITAE: 215.6
% PARA SALTO EN DFH
% IAE:  0.01867
% ISE:  1.94e-8
% ITAE: 0.448

load('Comparacion_de_metodos');

figure(10);
plot(CE_sistema_dfh.time,CE_sistema_dfh.signals.values,...
    CE_cascada_dfh.time,CE_cascada_dfh.signals.values);
grid on;
title('Respuesta de controladores frente a perturbaci�n de +1% Fh en Dfh');
legend('Control de lazo simple','Control en cascada');
xlim([0 800]);
xlabel('Tiempo [s]');
ylabel('CE');


figure(11);
plot(CE_sistema_sin_pert.time,CE_sistema_sin_pert.signals.values,...
    CE_cascada_sin_pert.time,CE_cascada_sin_pert.signals.values);
grid on;
title('Error en valores de equilibrio para ambos controles');
legend('Control de lazo simple','Control en cascada');
xlim([0 800]);
xlabel('Tiempo [s]');
ylabel('CE');

figure(12);
plot(CE_sistema.time,CE_sistema.signals.values,...
    CE_cascada.time,CE_cascada.signals.values);
grid on;
title('Respuesta a un salto de +2% en SP');
legend('Control de lazo simple','Control en cascada');
xlim([0 800]);
xlabel('Tiempo [s]');
ylabel('CE');


