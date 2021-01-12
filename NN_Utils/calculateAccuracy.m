function [accuracy] = calculateAccuracy(automaticMapping,idealMapping,notAssignedSymbol)
%calculate the accuracy between automaticMapping and idealMapping
if ~exist('notAssignedSymbol','var')
    notAssignedSymbol=-1;
end
 subs=idealMapping~=0;
 
%  accuracy=1-(length(find((subs.*automaticMapping) - idealMapping) ~= 0) / length(automaticMapping));
 accuracy=1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));
 
end

