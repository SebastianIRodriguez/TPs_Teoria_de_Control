function [ CE_SMITH, CE_DEFAULT ] = simular_sistemas(...
Kc_Smith,Tau_Smith,Kc_Normal,Tau_Normal,Fh0...
)
sim_results = sim('Predictor_de_smith.slx', 'SrcWorkspace', 'current');
CE_DEFAULT = sim_results.get('CE_DEFAULT');
CE_SMITH = sim_results.get('CE_SMITH');
end

