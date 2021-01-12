function [mpe] = calculateMPE(automaticMapping,idealMapping,NB)
%calculate the MPE between automaticMapping and idealMapping

mpe=0;
nMpe=0;
substitutions=(idealMapping~=0);
idealSubs=idealMapping.*substitutions;
automaticSubs=automaticMapping.*substitutions;

for i=1:length(idealMapping)
    if (idealSubs(i)~=0 && automaticSubs(i)~=0)
        mpe = mpe + norm(NB(:,automaticMapping(i)) - NB(:,idealMapping(i)));
        nMpe=nMpe+1;
    end
end

if (nMpe==0)
    mpe=-1;
else
    mpe=mpe/nMpe;
end

end

