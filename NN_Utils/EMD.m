function [D] = EMD(h1,h2)
    D=0;
    p=0;
    for i=1:size(h1,2)
        p=p+h1(i)-h2(i);
        D=D+abs(p);
    end
end

