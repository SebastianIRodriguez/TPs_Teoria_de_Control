%Programa para el calculo de los parametros de los controladores por el metodo de IMC
disp('Programa para el calculo de los parametros de los controladores por el metodo de IMC')
disp(' ')
Kp=input('Ingresar la ganancia estatica del sistema ');
tao=input('Ingresar la constante de tiempo del sistema ');
tita=input('Ingresar el tiempo muerto del sistema ');
L=input('Ingresar el valor del parametro ajustable del fltro ');
disp(' ')
disp('Controlador PI')
KcPI=tao/(L*Kp)
TaoiPI=tao

disp('Controlador PI-"Mejorado"')
KcPI_M=(2*tao+tita)/(2*L*Kp)
TaoiPI_M=tao+tita/2

disp('Controlador PID')
KcPID=(2*tao+tita)/(2*Kp*(L+tita))
TaoiPID=tao+tita/2
TaodPID=tao*tita/(2*tao+tita)
