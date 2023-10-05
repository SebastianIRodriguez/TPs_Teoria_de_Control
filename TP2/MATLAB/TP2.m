%% Modelo lineal de la planta:
s = tf('s');
Gpa = (-0.00024744 *(s-0.1886))/((s+0.4348)*(s+0.05047)*(s+0.01022));
Gpa_lc = Gpa/(1+Gpa);

%% 2.2.1 Análisis de la planta
% Graficar la respuesta al escalón del sistema sin corregir (realimentación con 
% ganancia unitaria), indicando error en estado estacionario, SV, tr2% y márgenes
% tr2% = 324 segundos
% SV = 0
% eEE = 1 - vf = 1 - 0.172 = 0.828
% Pmpa = infinito
% Gmpa  = 77.4276
figure(1);
step(Gpa_lc);
grid on;
[Gmpa,Pmpa,Wgmpa,Wpmpa] = margin(Gpa);

figure(2);
bode(Gpa);
grid on;

%% 2.2.2 Diseño del PD
% El sistema a lazo cerrado debe presentar:
% tr2% < 125 segundos
% SV<15% 
% e01 = 0

% *** Controlador PD
% Con el PD se obtuvo Pm = 52.6449; Gm = 2.3056
a = 3;
tau=9.388;
Gpd = 25.64*(1+a*tau*s)/(1+tau*s);

Gd = Gpd*Gpa;
Gd_lc = Gd/(1+Gd);

figure(3);
step(Gd_lc);
grid on;
title('Respuesta al escalón del PD + planta');

figure(4);
bode(Gd);
grid on;
title('Bode del PD + planta');

[Gmd,Pmd,Wgmd,Wpmd] = margin(Gd);

% *** Controlador PI
% Debemos poner un polo en cero y un cero a una frecuencia mucho menor a Wn

kpi = 0.00612415;   % Ganancia del PI
wpi = 0.006155;     % Frecuencia del cero del PI (10 veces menos que Wn)
Gpi = kpi * (1+(s/wpi))/s;

% *** Controlador PID
% Los márgenes iniciales son: Pm = 46.9373, Gm = 2.2099
G = Gpi*Gpa*Gpd;
G_lc = G/(1+G);

figure(5);
%[mag,phase]= bode(G,0.06155);
bode(G);
grid on;
title('Bode del PID + planta');
[Gm,Pm,Wgm,Wpm] = margin(G); 

figure(6);
step(G_lc);
grid on;
title('Respuesta al escalón del PID + planta');

%% Ajustes finales
% Modificando la ganancia y el cero del PI obtengo la respuesta deseada
% SV = 5%
% tr = 110 segundos
% Gm = 3.3044 veces (o 10.4 dB)
% Pm = 61.8255°
% error estacionario = 0 (integrador)

%C = 0.18 * (1+28.16*s)*(1+90.909*s)/(s*(1+9.346*s)); % Controlador PID
C = 49.091 * (s+0.0355)*(s+0.011)/(s*(s+0.107)); % Controlador PID
G = Gpa * C;
G_lc = G/(1+G);
[Gm,Pm,Wgm,Wpm] = margin(G); 

figure(7);
step(G_lc);
grid on;
title('Respuesta al escalón del PID corregido + planta');

%% 2.2.3 Verificación del desempeño

load('data.mat');
sim('CSTR_TP2_2023');

valor_inicial = 0.543;
valor_final = 0.543*1.02;
cota_superior = valor_final + (valor_final - valor_inicial) * 0.02;
cota_inferior = valor_final - (valor_final - valor_inicial) * 0.02;
cs = ones(1001) * cota_superior;
ci = ones(1001) * cota_inferior;

% Líneas para el tr2%
figure(8);
plot(t,cs,':r',t,ci,':r');
hold on;

% Respuesta al escalón
figure(8);
plot(t,C_E,t,SP_CE,'LineSmoothing','on','LineWidth',1.5);
grid on;
title('Respuesta de la planta controlada a un escalón de +2% en el SP');
xlabel('Tiempo [s]');
ylabel('C_E');
xlim([0 700]);
