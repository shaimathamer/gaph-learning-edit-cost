function [input] = NsubN_Histo_ESB_input(na,ea,a,nBins,histMin,histMax)
    [h,~]=generateHistogramEmbeddedStar(na,ea,a,[],[],[],nBins,histMin,histMax);
    input=[na(a,:),sum(ea(a,:)),h];
    
end
