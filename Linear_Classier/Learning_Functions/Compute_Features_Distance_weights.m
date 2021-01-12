function Features_Distance=Compute_Features_Distance_weights(AA,BB,w)

% Normalize features
[AA, BB] = normalizeFeatures(AA, BB);
Features_Distance = metricSSD(AA, BB,w);
end
%==========================================================================
% Generate correspondence metric matrix using Sum of Squared Differences
%==========================================================================
function scores = metricSSD(features1, features2,w)

% Need to obtain feature vector length to perform explicit row indexing 
% needed for code generation of variable sized inputs
N1=size(features1,1);
N2=size(features2,1);
vector_length = size(features1, 2);
scores = zeros(N1, N2,'single');

% used for code generation
for c = 1:N1
    for r = 1:N2
        %scores(c, r)= (((features1(c,1:vector_length) - features2(r,1:vector_length)).^2)*w);
        %scores(c, r)= length(w)*(((features1(c,1:vector_length) - features2(r,1:vector_length)).^2)*w);
        scores(c, r)= sqrt(sum(w'.*((features1(c,1:vector_length) - features2(r,1:vector_length)).^2)));
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