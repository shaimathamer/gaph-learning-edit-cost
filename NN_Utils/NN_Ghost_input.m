function [input] = NsubN_Ghost_input(na,ea,nb,eb)
    input=[na,nb,abs(sum(ea)-sum(eb))];
end
