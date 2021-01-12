function [distance,lab]=BP_Points_Centrality_h_Features(Vi,Vj,Features_Distance,EA,EB,InsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= BP_Points_Centrality_h(NA,NB,InsDel)
% Graph matching algorithm: BP
% Centrality: Points
% Linear Assignment solver: Jonker-Volgenant
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% InsDel: Cost of deleting or inserting a node

Nul=100000;
a=sum(EA(Vi,:)>0); 
b=sum(EB(Vj,:)>0);
na=size(EA,1);
nb=size(EB,1);

% Compute the cost between points
Q1=zeros(a,b);
ii=1;
for i=1:na
    if (EA(Vi,i)>0)
        jj=1;   
        for j=1:nb
            if(EB(Vj,j)>0)
                Q1(ii,jj)=Features_Distance(i,j);
                jj=jj+1;
            end
        end
        ii=ii+1;
    end
end

% Compute the insertion quadrant
Q2=Nul*(1-diag(ones(a,1)));
Q2=Q2+diag(InsDel*ones(a,1));

% Compute the deletion quadrant
Q3=Nul*(1-diag(ones(b,1)));
Q3=Q3+diag(InsDel*ones(b,1));

%Concatenate the four matrices and Hungarian
Q4=zeros(b,a);
QT=cat(1,Q1,Q3);
Q2=cat(1,Q2,Q4);
C=cat(2,QT,Q2);
lab=Hungarian(C);
distance=sum(sum(lab.*C));
lab=lab(1:a,:);
lab=lab(:,1:b);
lab=(vec2ind(lab')).*(sum(lab',1));
end