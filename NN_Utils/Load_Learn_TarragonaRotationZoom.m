
function [DB_Learning , DB_Test]=Load_Learn_TarragonaRotationZoom(database)
[Nodes, Edges, Images, Pixels,Labellings] = Load_TarragonaRotationZoom(database);
DB_Learning = [];
for Graph1=1:2: size(Nodes,2)
    for Graph2=1:2: size(Nodes,2)
        DB_Learning{end+1}.graph1.nodes=Nodes{Graph1};
        DB_Learning{end}.graph2.nodes=Nodes{Graph2};
        DB_Learning{end}.graph1.edges=Edges{Graph1};
        DB_Learning{end}.graph2.edges=Edges{Graph2};
        DB_Learning{end}.image1=Images{Graph1};
        DB_Learning{end}.image2=Images{Graph2};
        DB_Learning{end}.pixel1=Pixels{Graph1};
        DB_Learning{end}.pixel2=Pixels{Graph2};
        l=Labellings{Graph1};
        DB_Learning{end}.labelling=l{Graph2}.labellings;
    end
end
DB_Test = [];
for Graph1=2:2: size(Nodes,2)
    for Graph2=2:2: size(Nodes,2)
        DB_Test{end+1}.graph1.nodes=Nodes{Graph1};
        DB_Test{end}.graph2.nodes=Nodes{Graph2};
        DB_Test{end}.graph1.edges=Edges{Graph1};
        DB_Test{end}.graph2.edges=Edges{Graph2};
        DB_Test{end}.image1=Images{Graph1};
        DB_Test{end}.image2=Images{Graph2};
        DB_Test{end}.pixel1=Pixels{Graph1};
        DB_Test{end}.pixel2=Pixels{Graph2};
        l=Labellings{Graph1};
        DB_Test{end}.labelling=l{Graph2}.labellings;
    end
end


end
