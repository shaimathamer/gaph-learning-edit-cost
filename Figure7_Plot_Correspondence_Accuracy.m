% ***** Figure 7. ******
% Each run is Random 
close all;
clc;
clear;
%% Adding libraries
addpath('../BP_Functions');

%% Defining the graph matching method
% distfun = @BP_Degree_Centrality_h;
distfun = @BP_Clique_Centrality_h;

%% Defining parameters
V=1;
degree=0.5;
na=12;
nb=10;
Kv_Ground_Truth=4;
Ke_Ground_Truth=4;

%% Generating random graphs
    [NA,EA]=Random_Graph(na,V,degree);
    [NB,EB]=Random_Graph(nb,V,degree);
    [distance,lab_Ground_Truth]=distfun(NA,NB,EA,EB,Kv_Ground_Truth,Ke_Ground_Truth);
  
%% Plotting hamming distance
Kv=-1:1:9;
Ke=-1:1:9;
n=length(Kv);
m=length(Ke);
Hamming=zeros(n,m);
for i=1:n
    for j=1:m
            [dist,lab]=distfun(NA,NB,EA,EB,Kv(i),Ke(j));
            Hamming(i,j)=sum(lab==lab_Ground_Truth)/length(lab);
    end
    Done100=floor(100*i/n)
end
Figure7=figure
surf(Ke,Kv,Hamming);
xlabel('Ke');
ylabel('Kv');
title('Correspondence Accuracy');
saveas(Figure7,'Figure7.fig');
