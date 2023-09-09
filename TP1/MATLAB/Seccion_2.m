%tpo muerto(tita) 18.7500
%tau 141.1618
%ganancia 0.2081
%
% tita 18.7500
% tau=100
figure(2);
plot(CC_aj.time,CC_aj.signals.values+Ce0,C_E.time,C_E.signals.values);
legend('Salida aproximada','Salida real');
%plot(C_E.time,C_E.signals.values);
grid on;

%%
%tita 25
%tau 100

figure(3);
plot(CC_aj.time,CC_aj.signals.values+Ce0,C_E.time,C_E.signals.values);
legend('Salida aproximada','Salida real');
%plot(C_E.time,C_E.signals.values);
grid on;

%%
%tita 21.8
%tau 100

figure(4);
plot(CC_aj.time,CC_aj.signals.values+Ce0,C_E.time,C_E.signals.values);
legend('Salida aproximada','Salida real');
%plot(C_E.time,C_E.signals.values);
grid on;

%{
Programa para el calculo de los parametros de los controladores por el metodo de Cohen-Coon
 
Ingresar la ganancia estatica del sistema 0.2081
Ingresar la constante de tiempo del sistema 100
Ingresar el tiempo muerto del sistema 25
 
Controlador P
KcP = 20.8233

Controlador PI
KcPI = 17.6998
TaoiPI = 54.9107

Controlador PID
KcPID = 26.8300
TaoiPID = 55.8333
TaodPID = 8.6957
%}

%% Método ZN
% período último: 91,5
% k_úlltimo: 33.25
figure(5);
plot(Gu_Pu.time,Gu_Pu.signals.values);
grid on;

%{
ZN_Controladores
Programa para el calculo de los parametros de los controladores por el metodo de Ziegler-Nichols
 
Ingresar la ganancia ultima del sistema 33.25
Ingresar el periodo ultimo del sistema 91.5
 
Controlador P
KcP = 16.6250

Controlador PI
KcPI =N14.9625
TaoiPI = 76.2500

Controlador PID
KcPID = 19.9500
TaoiPID = 45.7500
TaodPID = 11.4375

%}

%% IMC

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
%}