function [distance,lab]=BP_Neural_Net_Centrality_h_NN_ESB_INS_pattern(NA,NB,EA,EB,func_NN, func_NN_input, func_NN_E, func_NN_E_input,func_NN_I, func_NN_I_input)

% francesc.serratosa@urv.cat
% [Distance,labelling]= BP_Clique_Centrality_h(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% Graph matching algorithm: BP
% Centrality: Clique
% Linear Assignment solver: Hungarian
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% EA, EB: Adjacency matrices. EA(i,j)=1: There is an edge between node i and j. 0: No edge.
% NO attributes on edges
% NodeInsDel: Cost of deleting or inserting a node
% ArcInsDel: Cost of deleting or inserting an edge

Nul=100000;
a=size(NA,1);
b=size(NB,1);
% % sA=zeros(a,1);
% % sB=zeros(b,1);
% % for i=1:a
% %     NeighboursA{i}=NA(EA(i,:)>0,:);
% %     s=size(NeighboursA{i});
% %     sA(i)=s(1);
% % end
% % for j=1:b
% %     NeighboursB{j}=NB(EB(j,:)>0,:);
% %     s=size(NeighboursB{j});
% %     sB(j)=s(1);
% % end

%%Q1 calculated from neuronal Network
% Q1=zeros(a,b);
% tic
% for i=1:a
%     for j=1:b
%         %input1 = [G1.Nodes(i,:),sum(G1.Edges(i,:)),G2.Nodes(j,:),sum(G2.Edges(j,:))];
%         input1 = [NA(i,:),sum(EA(i,:)),NB(j,:),sum(EB(j,:))];
%
%         output1 = net(input1');
%
%         Q1(i,j) = -output1(1); % Negatiu!!!!
%
%     end
% end
% toc
%%%%%%%%%%%%%%%%%%%%%

Q1=zeros(a,b);
for i=1:a
    for j=1:b
        output = func_NN(func_NN_input(NA(i,:),EA(i,:),NB(j,:),EB(j,:)));
        Q1(i,j) =1 - output(2) + output(1);
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%

Q1(Q1<0)=0;
Q1(Q1>2)=2;
Q1=2-Q1;

% Compute the insertion quadrant
Q3=Nul*ones(b);
for j=1:b
    output=func_NN_I(func_NN_I_input(NB(j,:),EB(j,:)));
    Q3(j,j) = 2-(1 - output(2) + output(1));
    if (Q3(j,j)>2)
        Q3(j,j)=2;
    end
end
Q3(Q3<0)=0;

% Compute the deletion quadrant
Q2=Nul*ones(a);
for j=1:a
    output=func_NN_E(func_NN_E_input(NA(j,:),EA(j,:)));
    Q2(j,j) = 2-(1 - output(2) + output(1));
    if (Q2(j,j)>2)
        Q2(j,j)=2;
    end
end
Q2(Q2<0)=0;


% Concatenate the four matrices and Hungarian
Q4=zeros(b,a);
QT=cat(1,Q1,Q3); Q2=cat(1,Q2,Q4);
C=cat(2,QT,Q2);
lab=Hungarian(C);
distance=sum(sum(lab.*C));
lab=lab(1:a,:);
lab=lab(:,1:b);
lab=(vec2ind(lab')).*(sum(lab',1));
end