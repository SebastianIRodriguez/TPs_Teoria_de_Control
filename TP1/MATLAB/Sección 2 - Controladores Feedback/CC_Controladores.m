%Programa para el calculo de los parametros de los controladores por el metodo de Cohen-Coon
disp('Programa para el calculo de los parametros de los controladores por el metodo de Cohen-Coon')
disp(' ')
Kp=input('Ingresar la ganancia estatica del sistema ');
tao=input('Ingresar la constante de tiempo del sistema ');
tita=input('Ingresar el tiempo muerto del sistema ');
disp(' ')
disp('Controlador P')
KcP=1/Kp*tao/tita*(1+(1/3)*(tita/tao))

disp('Controlador PI')
KcPI=1/Kp*tao/tita*(0.9+(1/12)*(tita/tao))
TaoiPI=tita*((30+3*(tita/tao))/(9+20*(tita/tao)))

disp('Controlador PID')
KcPID=1/Kp*tao/tita*((4/3)+(1/4)*(tita/tao))
TaoiPID=tita*((32+6*(tita/tao))/(13+8*(tita/tao)))
TaodPID=tita*(4/(11+2*(tita/tao)))
