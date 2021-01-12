function [distance,lab]=BP_Degree_Centrality_h_RotationZoom(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= BP_Degree_Centrality_h_RotationZoom(GA,GB,NodeInsDel,ArcInsDel)
% Graph matching algorithm: BP
% Centrality: Degree
% Linear Assignment solver: Hungarian
% GA,GB: Matrices that are the attributes on nodes and the edges.
% G.Nodes(i): N-dimensional attribute of node i in the first graph.
% G.Edges(i,j)=1: There is an edge between node i and j. 0: No edge.
    % NO attributes on edges
% NodeInsDel: Cost of deleting or inserting a node
% ArcInsDel: Cost of deleting or inserting an edge

Nul=100000;
a=size(NA,1); 
b=size(NB,1);
sA=zeros(a,1);
sB=zeros(b,1);
for i=1:a
    AA{i}=NA(i,:);
    NeighboursA{i}=NA(EA(i,:)>0,:);
    s=size(NeighboursA{i});
    sA(i)=s(1);
end
for j=1:b
    BB{j}=NB(j,:);
    NeighboursB{j}=NB(EB(j,:)>0,:);
    s=size(NeighboursB{j});
    sB(j)=s(1);
end

% Normalize features
method = 'nearestneighborratio';
metric = 'ssd';
[AA, BB] = normalizeFeatures(AA, BB, ...
method, metric);

distMatrix = metricSSD(AA, BB, size(AA,2), size(BB,2), 'single');

% Compute the cost between nodes
Q1=zeros(a,b);
for i=1:a
    for j=1:b
        if((sA(i)>0) && (sB(j)>0))
            Q1(i,j)=distMatrix(i,j)+norm(sA(i)-sB(j))*ArcInsDel;
        end
        if((sA(i)>0) && (sB(j)==0))
            Q1(i,j)=distMatrix(i,j)+ sA(i)*ArcInsDel;
        end
        if((sA(i)==0) && (sB(j)>0))
            Q1(i,j)=distMatrix(i,j)+ sB(j)*ArcInsDel;
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

% Concatenate the four matrices and Hungarian
Q4=zeros(b,a);
QT=cat(1,Q1,Q3); Q2=cat(1,Q2,Q4);
C=cat(2,QT,Q2);
lab=Hungarian(C);
distance=sum(sum(lab.*C));
lab=lab(1:a,:);
lab=lab(:,1:b);
lab=(vec2ind(lab')).*(sum(lab',1));

%lab(find(lab==0)) = -1;
end

%==========================================================================
% Generate correspondence metric matrix using Sum of Squared Differences
%==========================================================================
function scores = metricSSD(features1, features2, N1, N2, output_class)

% Need to obtain feature vector length to perform explicit row indexing 
% needed for code generation of variable sized inputs
vector_length = size(features1, 1);
scores = zeros(N1, N2, output_class);

% used for code generation
for c = 1:N1
    for r = 1:N2
        scores(c, r) = sum((features1(1:vector_length, c) - ...
            features2(1:vector_length, r)).^2);
    end
end
end

%==========================================================================
% Normalize features to be unit vectors
%==========================================================================
function [features1, features2] = normalizeFeatures(features1, features2, ...
    method, metric)

for i = 1:length(features1)
    f1(:,i) = features1{i}';
end

for i = 1:length(features2)
    f2(:,i) = features2{i}';
end

f1 = cast(f1, 'double');
f2 = cast(f2, 'double');

% Convert feature vectors to unit vectors
features1 = normalizeX(f1);
features2 = normalizeX(f2);
end

%==========================================================================
% Normalize the columns in X to have unit norm.
%==========================================================================
function X = normalizeX(X)
Xnorm = sqrt(sum(X.^2, 1));
X = bsxfun(@rdivide, X, Xnorm);

% Set effective zero length vectors to zero
X(:, (Xnorm <= eps(single(1))) ) = 0;
end