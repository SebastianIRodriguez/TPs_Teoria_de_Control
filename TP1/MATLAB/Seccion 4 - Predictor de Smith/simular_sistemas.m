function [ out_SMITH, out_DEFAULT ] = simular_sistemas()
load('backup_workspace');
sim_results = sim('Predictor_de_smith_con_planta.slx', 'SrcWorkspace', 'current');
out_SMITH = sim_results.get('CE_SMITH');
%sim_results = sim('solo_feedback.slx', 'SrcWorkspace', 'current');
out_DEFAULT = [];%sim_results.get('CE_DEFAULT');
end

