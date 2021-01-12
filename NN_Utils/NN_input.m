function [input] = NN_input(na,ea,nb,eb)
    input=[na,sum(ea),nb,sum(eb)];
end
