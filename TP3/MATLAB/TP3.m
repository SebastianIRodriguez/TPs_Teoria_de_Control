%% Ej 2.1
s = tf('s');
C_continua = 34.364 *(s+0.0355)*(s+0.011)/(s*(s+0.107));
bode(C_continua)
grid on;

T_chico = 2; 
g_pz_tc = c2d(C_continua, T_chico, 'matched');   % utilizando mapeo de polos y ceros
g_bloq_tc = c2d(C_continua, T_chico, 'zoh');     % utilizando el método del bloqueador equivalente
g_trap_tc = c2d(C_continua, T_chico, 'tustin');  % utilizando la regla trapezoidal
g_adel_tc = recadel(C_continua, T_chico);         % utilizando la regla rectangular por adelanto
g_atras_tc = recatras(C_continua, T_chico);

T_grande = 25; 
g_pz_tg = c2d(C_continua, T_grande, 'matched');   % utilizando mapeo de polos y ceros
g_bloq_tg = c2d(C_continua, T_grande, 'zoh');     % utilizando el método del bloqueador equivalente
g_trap_tg = c2d(C_continua, T_grande, 'tustin');  % utilizando la regla trapezoidal
g_adel_tg = recadel(C_continua, T_grande);         % utilizando la regla rectangular por adelanto
g_atras_tg = recatras(C_continua, T_grande);

%% 2.1.2
figure(1);
pzmap(g_pz_tc, g_bloq_tc, g_trap_tc, g_adel_tc, g_atras_tc);
legend('Mapeo','Bloqueador','Trapezoidal','Rec Adelanto','Rec Atraso');
grid on;

figure(2);
pzmap(g_pz_tg, g_bloq_tg, g_trap_tg, g_adel_tg, g_atras_tg);
legend('Mapeo','Bloqueador','Trapezoidal','Rec Adelanto','Rec Atraso');
grid on;


%% 2.1.3 Diagramas de Bode
figure(3);
title('Bode continuo vs equivalentes discretos');
bode(C_continua, g_pz_tc, g_bloq_tc, g_trap_tc, g_adel_tc, g_atras_tc);
legend('Continua','Mapeo','Bloqueador','Trapezoidal','Rec Adelanto','Rec Atraso');
grid on;

figure(4);
title('Bode continuo vs equivalentes discretos');
bode(C_continua, g_pz_tg, g_bloq_tg, g_trap_tg, g_adel_tg, g_atras_tg);
legend('Continua','Mapeo','Bloqueador','Trapezoidal','Rec Adelanto','Rec Atraso');
grid on;

%% 2.1.4 Controlador discreto
load('data.mat');
Ts = 2;
k = 32.498;
zero1 = 0.9782;
zero2 = 0.9314;
pole1 = 1;
pole2 = 0.8067;

figure(5);
sim('CSTR_TP3_2023');
sim('CSTR_TP2_2023');
plot(t,C_E,t,C_E_continuo,'LineSmoothing','on');
legend('Controlador discreto', 'Controlador continuo');
grid on;

Ts = 25;
k = 24.143;
zero1 = 0.7582;
zero2 = 0.3853;
pole1 = 1;
pole2 = 0.1444;
figure(6);
sim('CSTR_TP3_2023');
plot(t,C_E,t,C_E_continuo,'LineSmoothing','on');
legend('Controlador discreto', 'Controlador continuo');
grid on;


%% 2.2.2
T = 4;
% Tranferencia continua sin tiempo muerto
Gs= 0.000116327/((s+0.05505)*(s+0.01014));

% Transferencia discreta sin tiempo muerto
Gz = zpk(c2d(Gs, T, 'zoh')); 

% Transferencia en W
Gw_raw = transfw(Gz);
raw_gain = evalfr(Gw_raw,0);

Gw= -2.0121e-05*(s-0.5)/((s+0.05483)*(s+0.01014));
new_gain = evalfr(Gw,0);
kw = raw_gain/new_gain;
Gw = zpk(Gw * kw);

%% Controlador PD
% El margen de fase original es infinito, la ganancia nunca supera la
% unidad

figure(6);
bode(Gw);
grid on;
title('Bode de planta');
[Gm_or,Pm_or,Wgm_or,Wpm_or] = margin(G_1);

a = 3;
wn = 0.06155; 
tau=9.388;
Gpd =(1+a*tau*s)/(1+tau*s);
G_1 = Gpd*Gw;
[mag,phase] = bode(G_1,wn);
kpd = 1/mag;
G_1 = kpd * G_1;
Gpd = Gpd * kpd;

figure(7);
bode(G_1);
grid on;
title('Bode del PD + planta');
[Gmd,Pmd,Wgmd,Wpmd] = margin(G_1);

%% Controlador PI
% Debemos poner un polo en cero y un cero a una frecuencia mucho menor a Wn

wpi = 0.006155;     % Frecuencia del cero del PI (10 veces menos que Wn)
Gpi = wpi * (1+(s/wpi))/s;

% *** Controlador PID 
G_pid = Gpi*Gpd;
G_lc = (G_pid*Gw)/(1+(G_pid*Gw));

figure(8);
[mag,phase]= bode(G_pid*Gw,0.06155);
bode(G_pid*Gw);
grid on;
title('Bode del PID + planta');
[Gm,Pm,Wgm,Wpm] = margin(Gw*G_pid); 

figure(9);
step(G_lc);
grid on;
title('Respuesta al escalón del PID + planta');

% El sistema queda con un PM de 68.1332° y Gm de 7.3864

%% Ajustes finales
% Modificando la ganancia y el cero del PI obtengo la respuesta deseada
% SV = 5.54%
% tr = 102 segundos
% Gm = 6.025 veces (o 15.6 dB)
% Pm = 59.3°
% error estacionario = 0 (integrador)

%sisotool(Gw);
% Ganancia original: 0,156506

C = 0.25 * (1+28.161*s)*(1+122.624157*s)/(s*(1+9.38967*s)); % Controlador PID
%C = 49.091 * (s+0.0355)*(s+0.011)/(s*(s+0.107)); % Controlador PID
Gc = Gw * C;
Gc_lc = Gc/(1+Gc);
[Gm,Pm,Wgm,Wpm] = margin(Gc); 

figure(10);
[ycc,tcc] = step(Gc_lc,200);
plot(tcc,ycc,'LineSmoothing','on','LineWidth',1.5);
grid on;
title('Respuesta al escalón de la planta + PID corregido');
xlabel('Tiempo [s]');
ylabel('C_E');
grid on;

figure(11);
bode(Gw, G_pid*Gw, Gc);
grid on;
title('Bode de la planta sin control y controlada');
legend('Sin control','Controlada sin ajuste','Controlada ajustada');
grid on;

figure(12);
bode(Gw, Gc);
grid on;
title('Bode de la planta sin ajuste y ajustada');
legend('Sin ajuste','Ajustada');

%% Antitrasnformada y verificación de desempeño
Ts = 4;
Cz = antitransfw(zpk(C),Ts);

load('data.mat');
sim('CSTR_TP3_2023_w'); % Tiene el escalón en SP

valor_inicial = 0.543;
valor_final = 0.543*1.02;
cota_superior = valor_final + (valor_final - valor_inicial) * 0.02;
cota_inferior = valor_final - (valor_final - valor_inicial) * 0.02;
cs = ones(1001) * cota_superior;
ci = ones(1001) * cota_inferior;

sv_superior = valor_final + (valor_final - valor_inicial) * 0.15;
sv_inferior = valor_final - (valor_final - valor_inicial) * 0.15;
svs = ones(1001) * sv_superior;
svi = ones(1001) * sv_inferior;

% Respuesta al escalón
figure(13);
plot(t,C_E,t,SP_CE,'LineSmoothing','on','LineWidth',1.5);
grid on;
title('Respuesta de la planta controlada a un escalón de +2% en el SP');
xlabel('Tiempo [s]');
ylabel('C_E');
hold on;

% Líneas para el tr2%
figure(13);
plot(t,cs,':r',t,ci,':r','LineWidth',1.12);
xlim([50 500]);

% Líneas para el sv%
figure(13);
plot(t,svs,'--y',t,svi,'--y','LineWidth',1.12);
xlim([50 500]);

legend('Variable controlada','Set point','Limites de +/- 2%','Limites de +/- 15%');

%% Escalón en Ti
sim('CSTR_TP3_2023_w_2');

valor_inicial = 0.543;
valor_final = 0.543;

sv_superior = valor_final + valor_final * 0.01;
sv_inferior = valor_final - valor_final * 0.01;
svs = ones(1001) * sv_superior;
svi = ones(1001) * sv_inferior;

% Respuesta al escalón
figure(14);
plot(t,C_E,t,SP_CE,'LineSmoothing','on','LineWidth',1.5);
grid on;
title('Respuesta de la planta controlada a un escalón de +1% en el Ti');
xlabel('Tiempo [s]');
ylabel('C_E');
hold on;

% Líneas para el sv%
figure(14);
plot(t,svs,':r','LineWidth',1.12);
xlim([50 800]);

legend('Variable controlada','Set point','Limite de +1%');

