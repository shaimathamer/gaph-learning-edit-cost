function [input] = NN_Ghost_INS_input(nb,eb)
    input=[-nb,-sum(eb),nb,sum(eb)];
end
