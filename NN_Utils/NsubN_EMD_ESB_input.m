function [input] = NsubN_EMD_ESB_input(na,ea,a,nBins,histMin,histMax)
    [~,e]=generateHistogramEmbeddedStar(na,ea,a,[],[],[],nBins,histMin,histMax);
    input=[na(a,:),sum(ea(a,:)),e];
    
end
