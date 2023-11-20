%% Ej 2.1
s = tf('s');
C_continua = 34.364 * (s+0.0355)*(s+0.011)/(s*(s+0.107));
bode(C_continua)

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
a = 3;
wn = 0.06155; 
tau=9.388;
Gpd =(1+a*tau*s)/(1+tau*s);
G_1 = Gpd*Gw;
[mag,phase] = bode(G_1,wn);
kpd = 1/mag;
G_1 = kpd * G_1;



%% RAGAZZINI
Gz = c2d(Gs, T, 'zoh');
T = 4;
Ts = T;
load('data.mat');
% Denominador de H(z)
epsilon = 0.52;
wn = 0.06155; 
r = exp(-epsilon*wn*T);
theta = wn*T*sqrt(1-epsilon^2);

% Calculo H(z)
z = tf('z', T);
Hz_ = z^-2 / (z^2 - 2 * r * cos(theta) * z + r^2);
% Ajusto ganancia para tener |H(z=1)| = 1
[mag, phase] = bode(Hz_, 1);
K = 1/mag;
Hz = K * Hz_;

% Expresion del controlador
Dz = 1/(Gz*z^-2) * Hz/(1-Hz);
zeros = zero(Dz);
poles = pole(Dz);

%% RAGAZZINI 2
z = tf('z', T);
Gz = c2d(Gs, T, 'zoh');
Gz = (Gz*z^-2);
T = 4;
Ts = T;
load('data.mat');
% Denominador de H(z)
epsilon = 0.52; %0.52
%wn = 0.075;
wn = 0.06155; 
r = exp(-epsilon*wn*T);
theta = wn*T*sqrt(1-epsilon^2);

% Calculo H(z)
%Hz_ = (z-0.9168)*(z-0.9388)*z^-2 / (z^2 - 2 * r * cos(theta) * z + r^2);
Hz_ = z^-1 / (z^2 - 2 * r * cos(theta) * z + r^2);
%Hz_ = z^-2 / (z^2 - 2 * r * cos(theta) * z + r^2); % con este anda
% Ajusto ganancia para tener |H(z=1)| = 1
mag = evalfr(Hz_,1);
K = 1/mag;
Hz = K * Hz_;

% Expresion del controlador
Dz = Hz/(Gz*(1-Hz));

Glcz = (Dz*Gz)/(1+(Dz*Gz));
[y,t] = step(Glcz,500);

zeros = zero(Dz);
poles = pole(Dz);

valor_inicial = 0;
valor_final = 1;
cota_superior = valor_final + (valor_final - valor_inicial) * 0.02;
cota_inferior = valor_final - (valor_final - valor_inicial) * 0.02;
cs = ones(length(t)) * cota_superior;
ci = ones(length(t)) * cota_inferior;

sv_superior = valor_final + (valor_final - valor_inicial) * 0.15;
sv_inferior = valor_final - (valor_final - valor_inicial) * 0.15;
svs = ones(length(t)) * sv_superior;
svi = ones(length(t)) * sv_inferior;

% Respuesta al escalón
figure(13);
plot(t,y,'LineSmoothing','on','LineWidth',1.5);
grid on;
title('Respuesta de la planta controlada a un escalón de +2% en el SP');
xlabel('Tiempo [s]');
ylabel('C_E');
hold on;

% Líneas para el tr2%
figure(13);
plot(t,cs,':r',t,ci,':r','LineWidth',1.12);

% Líneas para el sv%
figure(13);
plot(t,svs,'--y',t,svi,'--y','LineWidth',1.12);
xlim([0 300]);

legend('Variable controlada','Limites de +/- 2%','Limites de +/- 15%');


%% Antitrasnformada y verificación de desempeño
Ts = 4;

%k_ajuste = 0.496;
% 0.5 casi casi
k_ajuste = 0.496;

load('data.mat');
sim('CSTR_TP3_2023_Ragazzini'); % Tiene el escalón en SP

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

% Líneas para el sv%
figure(13);
plot(t,svs,'--y',t,svi,'--y','LineWidth',1.12);
xlim([50 500]);

legend('Variable controlada','Set point','Limites de +/- 2%','Limites de +/- 15%');

%%
figure(1);
bode(Dz*Gz);
grid on;

figure(2);
Glcz = (Dz*Gz)/(1+(Dz*Gz));
step(Glcz);
grid on;