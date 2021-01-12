function [maxH,minH] = calculateMaximumMinimumPerAttribute(P,P2)
%CALCULATEMAXIMUMMINIMUMPERATTRIBUTE Summary of this function goes here
%   Detailed explanation goes here

if nargin==1
    maxH=ones(length(P{1}.graph1.nodes(1,:)),1).*double(intmin);
    minH=ones(length(P{1}.graph1.nodes(1,:)),1).*double(intmax);
    
    for i = 1:size(P,2)
        for j=1:size(P{1}.graph1.nodes,2)
            
            maxH(j)=max([maxH(j),max(P{i}.graph1.nodes(:,j)),max(P{i}.graph2.nodes(:,j))]);
            minH(j)=min([minH(j),min(P{i}.graph1.nodes(:,j)),min(P{i}.graph2.nodes(:,j))]);
        end
    end
else
    maxH=ones(length(P{1}.nodes(1,:)),1).*double(intmin);
    minH=ones(length(P{1}.nodes(1,:)),1).*double(intmax);
    
    for i = 1:size(P,2)
        for j=1:size(P{1}.nodes,2)
            
            maxH(j)=max([maxH(j),max(P{i}.nodes(:,j)),max(P2{i}.nodes(:,j))]);
            minH(j)=min([minH(j),min(P{i}.nodes(:,j)),min(P2{i}.nodes(:,j))]);
        end
    end
end
end

