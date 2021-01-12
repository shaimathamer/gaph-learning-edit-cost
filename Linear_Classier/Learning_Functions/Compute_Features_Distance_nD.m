function Features_Distance_nD=Compute_Features_Distance_nD(AA,BB)
Features_Distance_nD=zeros(size(AA,2),size(AA,1),size(BB,1));
% Normalize features for all attributes
[AAA, BBB] = normalizeFeatures(AA,BB);
for t=1:size(AA,2)
    Features_Distance_nD(t,:,:) = metricSSD_nD(AAA, BBB,t);
end
end
%==========================================================================
% Generate correspondence metric matrix using Sum of Squared Differences
%==========================================================================
function scores = metricSSD_nD(features1, features2,t)

% Need to obtain feature vector length to perform explicit row indexing 
% needed for code generation of variable sized inputs
N1=size(features1,1);
N2=size(features2,1);
scores = zeros(N1, N2);
for c = 1:N1
    for r = 1:N2
        scores(c, r) = (features1(c,t) - features2(r,t))^2;
    end
end
end

%==========================================================================
% Normalize features to be unit vectors
%==========================================================================
function [features1, features2] = normalizeFeatures(features1, features2)

% Convert feature vectors to unit vectors
features1 = normalizeX(features1);
features2 = normalizeX(features2);
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