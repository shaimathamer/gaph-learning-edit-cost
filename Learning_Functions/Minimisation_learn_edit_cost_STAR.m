function [Kv Ke] = Minimisation_learn_edit_cost_STAR(data, Kv, Ke, lambda)
%[Kn, Ke] = learneditcosts(learningSet, costs, lambda)
% Learning edit costs using Edit Cost Error function
% Please cite:
% X. Cortes & F. Serratosa,
%Learning Graph-Matching Edit-Costs based on the Optimality of the Oracle's Node Correspondences,
%Pattern Recognition Letters, 2015. http://dx.doi.org/10.1016/j.patrec.2015.01.009
%INPUT:
%learningset.graph1: first graph
%learningset.graph2: second graph
%learningset.labelling: ground truth labelling between g1 and g2 
%Initialization of Kn and Ke
% lambda: Weight of the regularisation term
%OUTPUT:
% Kn: cost of node insertion and deletion
% Ke: cost of edge insertion and deletin

%% variables
global LEARNING_SET;
global LAMBDA;
LEARNING_SET = data;
LAMBDA = lambda;
%% main code
o = optimset('MaxFunEvals',Inf, 'MaxTime', Inf,'MaxIter',Inf);
costs = [Kv, Ke];
%tic
costs_end = fminsearch(@editcosterror_STAR,costs,o);
%toc
Kv = costs_end(1);
Ke = costs_end(2);
clear LEARNING_SET;
clear LAMBDA;
end