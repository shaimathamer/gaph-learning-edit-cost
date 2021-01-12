function [input] = NsubN_EMD_input(na,ea,a,nb,eb,b,nBins,histMin,histMax) 
    [~,e]=generateHistogramEmbeddedStar(na,ea,a,nb,eb,b,nBins,histMin,histMax);
    input=[na(a,:),nb(b,:),abs(sum(ea(a,:))-sum(eb(b,:))),e];
end
