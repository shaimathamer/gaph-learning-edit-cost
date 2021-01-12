function [input] = NsubN_Histo_input(na,ea,a,nb,eb,b,nBins,histMin,histMax) 
    [h,~]=generateHistogramEmbeddedStar(na,ea,a,nb,eb,b,nBins,histMin,histMax);
    input=[na(a,:),nb(b,:),abs(sum(ea(a,:))-sum(eb(b,:))),h];
end
