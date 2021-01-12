function [h,emd] = generateHistogramEmbeddedStar(n1,e1,a,n2,e2,b,nBins, min, max)
%GENERATEHISTOGRAMEMBEDDEDSTAR Summary of this function goes here
%   Detailed explanation goes here

mask=[1 2 3 2 1];

if ~isempty(n2)
    h=zeros(length(n1(a,:))*2,nBins);
else
    h=zeros(length(n1(a,:)),nBins);
end
emd=0;

for k=1:length(n1(a,:))
    values=[];
    edges=min(k):abs(max(k)-min(k))/(nBins):max(k);
    for l=1:length(e1(a,:))
        if(e1(a,l)~=0)
            values=[values n1(l,k)];
        end
    end
    if (max(k)==min(k))
        h(k,:)=length(values).*ones(1,nBins);
    else
        h(k,:)=conv(histcounts(values,edges),mask,'same');
    end
end

if ~isempty(n2)
    for k=1:length(n2(b,:))
        values=[];
        edges=min(k):abs(max(k)-min(k))/(nBins):max(k);
        for l=1:length(e2(b,:))
            if(e2(b,l)~=0)
                values=[values n2(l,k)];
            end
        end
        if (max(k)==min(k))
            h(length(n1(a,:))+k,:)=length(values).*ones(1,nBins);
        else
            h(length(n1(a,:))+k,:)=conv(histcounts(values,edges),mask,'same');
        end
    end
end

if ~isempty(n2)
    despl=size(h,1)/2;
    emd=zeros(despl,1);

    for i=1:size(h,1)/2
        emd(i)=EMD(h(i,:),h(i+despl,:));
    end
end

h=reshape(h',1,[]);
emd=emd';
end

