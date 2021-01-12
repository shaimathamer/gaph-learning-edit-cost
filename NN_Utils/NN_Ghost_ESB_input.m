function [input] = NN_Ghost_ESB_input(na,ea)
    input=[na,sum(ea),-na,-sum(ea)];
end
