%Programa para el calculo de los parametros de los controladores por el metodo de Ziegler-Nichols
disp('Programa para el calculo de los parametros de los controladores por el metodo de Ziegler-Nichols')
disp(' ')
Ku=input('Ingresar la ganancia ultima del sistema ');
Pu=input('Ingresar el periodo ultimo del sistema ');
disp(' ')
disp('Controlador P')
KcP=0.50*Ku

disp('Controlador PI')
KcPI=0.45*Ku
TaoiPI=Pu/1.2

disp('Controlador PID')
KcPID=0.60*Ku
TaoiPID=Pu/2
TaodPID=Pu/8
