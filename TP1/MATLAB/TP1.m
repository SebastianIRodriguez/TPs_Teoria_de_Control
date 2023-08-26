%% TP 1 Teoría de Control (TDC) 2023
% Datos del reactor
clear all;
load data

%% Datos del step test
%load Data_step_test
% Descripción archvio
% Ti_Ce 
% 1 Columna / 2 Columna / 3 Columna 
% Nro muestra / Ti / Ce

% Fh_Ce
% 1 Columna / 2 Columna / 3 Columna 
% Nro muestra / Fh / Ce

%% Entradas del sistema en el punto de equilibrio
Ci0=1.1367;   % [mol/m3] Concentración de componente entrante
Ti0=298;  % [ºK] Temperatura de componente entrante
Fi0=1; % [m3/seg] Flujo de componente entrante
Th0=473;      %[ºK] Temperatura del refrigerante entrante

% Variables manipuladas del sistema en el punto de equilibrio
Fh0=0.8946; %[m3/seg] Caudal del refrigerante
Ce0=0.543; % [mol/m3] Concentración de componente saliente
Ap0=49.978; % Porcentaje de apertura 

% Salida con el sistema en el punto de equilibrio
TJ0= 176.800605; % [ºK] Temperatura de la camisa

% Perturbaciones
DFh=Fh0*0.01; %[ m3/seg] Caudal de perturbación

%% Puntos de operación
T=323;
Ce=0.543;
Tj=408.9494;
