function [distance,lab]=BP_Points_Centrality_h_nD(NA,NB,w,InsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= BP_Points_Centrality_h(NA,NB,InsDel)
% Graph matching algorithm: BP
% Centrality: Points
% Linear Assignment solver: Jonker-Volgenant
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% InsDel: Cost of deleting or inserting a node

Nul=100000;
a=size(NA,1); 
b=size(NB,1);
% Compute the cost between points
Q1=zeros(a,b);
for i=1:a
    for j=1:b
        Q1(i,j)=w*(abs(NA(i,:)-NB(j,:)))';
    end
end

% Compute the insertion quadrant
Q2=Nul*ones(a);
for i=1:a
        Q2(i,i)=InsDel;
end

% Compute the deletion quadrant
Q3=Nul*ones(b);
for j=1:b
        Q3(j,j)=InsDel;
end

%Concatenate the four matrices and Hungarian
minQ1=min(min(Q1));
minQ2=min(min(Q2));
minQ3=min(min(Q3));
minQ4=min(minQ1,min(minQ2,minQ3));
if minQ4<0
    Q4=minQ4*ones(b,a);
else
    Q4=zeros(b,a);
end
QT=cat(1,Q1,Q3); Q2=cat(1,Q2,Q4);
C=cat(2,QT,Q2);
lab=Hungarian(C);
distance=sum(sum(lab.*C));
lab=lab(1:a,:);
lab=lab(:,1:b);
lab=(vec2ind(lab')).*(sum(lab',1));
end