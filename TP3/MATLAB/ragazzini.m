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
% Denominador de H(z)
epsilon = 0.52;
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

%%
Ts = 4;
%%
plot(C_E.time, C_E.signals.values)