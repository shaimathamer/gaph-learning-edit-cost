function [input] = NsubN_EMD_INS_input(na,ea,a,nBins,histMin,histMax)
    [~,e]=generateHistogramEmbeddedStar(N1,E1,a,[],[],[],nBins,histMin,histMax);
    input=[na,nb,abs(sum(ea)-sum(eb)),e];
    
end
