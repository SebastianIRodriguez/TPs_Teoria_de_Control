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
KcPI = 24.0269
TaoiPI = 100

figure(9);
plot(CE_SMITH.time,CE_SMITH.signals.values);
grid on;