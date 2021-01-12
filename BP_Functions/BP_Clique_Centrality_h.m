function [distance,lab]=BP_Clique_Centrality_h(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
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
sA=zeros(a,1);
sB=zeros(b,1);
for i=1:a
    NeighboursA{i}=NA(EA(i,:)>0,:);
    s=size(NeighboursA{i});
    sA(i)=s(1);
end
for j=1:b
    NeighboursB{j}=NB(EB(j,:)>0,:);
    s=size(NeighboursB{j});
    sB(j)=s(1);
end

% Compute substitution quadrant
Q1=zeros(a,b);
for i=1:a
    for j=1:b
        Q1(i,j)=norm(NA(i,:)-NB(j,:));
        if((sA(i)>0) && (sB(j)>0))
            Q1(i,j)=Q1(i,j)+BP_Points_Centrality_h(NeighboursA{i},NeighboursB{j},NodeInsDel+ArcInsDel);
        end
        if((sA(i)>0) && (sB(j)==0))
            Q1(i,j)=Q1(i,j)+ sA(i)*(NodeInsDel+ArcInsDel);
        end
        if((sA(i)==0) && (sB(j)>0))
            Q1(i,j)=Q1(i,j)+ sB(j)*(NodeInsDel+ArcInsDel);
        end
        
    end
end

% Compute the insertion quadrant
Q2=Nul*ones(a);
for i=1:a
        Q2(i,i)=NodeInsDel+(NodeInsDel+ArcInsDel)*sA(i);
end

% Compute the deletion quadrant
Q3=Nul*ones(b);
for j=1:b
        Q3(j,j)=NodeInsDel+(NodeInsDel+ArcInsDel)*sB(j);
end

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