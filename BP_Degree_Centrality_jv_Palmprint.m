function [distance,lab,runtime]=BP_Degree_Centrality_jv_Palmprint(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= BP_Degree_Centrality_jv(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% Graph matching algorithm: BP
% Centrality: Degree
% Linear Assignment solver: Jonker-Volgenant
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% EA, EB: Adjacency matrices. EA(i,j)=1: There is an edge between node i and j. 0: No edge.
% NO attributes on edges
% NodeInsDel: Cost of deleting or inserting a node
% ArcInsDel: Cost of deleting or inserting an edge
tic;
% this weights gauges the euclidean distance and the
% angular distance between minutiae.
lambda=0.85;

Cost_Type=1000;
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
    %transform the input palmprint into the position of the output palmprint
    NB_new=houghTransform(NA,NB);   
for i=1:a
    for j=1:b
        if NA(i,4)==NB(j,4)
            add(1)=abs(NA(i,3)-NB_new(j,3));
            add(2)=360-add(1);
            ad=min(add);
            ed=sqrt(((NA(i,1)-NB_new(j,1))^2)+((NA(i,2)-NB_new(j,2))^2));
            Q1(i,j)= lambda*ad+(1-lambda)*ed;
            if((sA(i)>0) && (sB(j)>0))
                Q1(i,j)=Q1(i,j)+norm(sA(i)-sB(j))*ArcInsDel;
            end
            if((sA(i)>0) && (sB(j)==0))
                Q1(i,j)=Q1(i,j)+ sA(i)*ArcInsDel;
            end
            if((sA(i)==0) && (sB(j)>0))
                Q1(i,j)=Q1(i,j)+ sB(j)*ArcInsDel;
            end
        else
            %minutiae are not of the same type, then cost should be high
            Q1(i,j)=Cost_Type;
        end
    end
end

% Compute the insertion quadrant
Q2=Nul*ones(a);
for i=1:a
        Q2(i,i)=NodeInsDel+ArcInsDel*sA(i); 
end

% Compute the deletion quadrant
Q3=Nul*ones(b);
for j=1:b
        Q3(j,j)=NodeInsDel+ArcInsDel*sB(j); 
end

% Concatenate the four matrices and Jonker-Volgenant
Q4=zeros(b,a);
QT=cat(1,Q1,Q3); Q2=cat(1,Q2,Q4);
C=cat(2,QT,Q2);
[lab,distance,v,u,costMat] = lapjv(C);
lab=lab(1:a);
L=lab<=b;
lab=lab.*L;

for i=1:length(lab)
    if lab(i)==0
        lab(i)=-1;
    else
    end
end
lab(find(lab==0)) = -1;
runtime=toc;
end