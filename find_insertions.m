lab = [ 3 5 7];
M = 10;
for t = 1: M
    d = (lab == t);
    if (sum(d)==0)
        if (quality(t)==0)
          delete=1;
        end
    end
end
