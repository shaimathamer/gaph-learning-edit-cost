function data =  LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers)
data=[];
Max_Register= size(Selected_Registers,2);
for i =1:Max_Register
    Register=Selected_Registers(i);
    [G1,G2,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
        data{end+1}.graph1.nodes=G1.Nodes;
        data{end}.graph2.nodes=G2.Nodes;
        data{end}.graph1.edges=G1.Edges;
        data{end}.graph2.edges=G2.Edges;
        data{end}.labelling=f;
        lll=data{end}.labelling~=-1;
        data{end}.labelling=data{end}.labelling.*lll;
end
end