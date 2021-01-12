
function [Nodes, Edges, Images,Pixels,Labellings] = Load_TarragonaRotationZoom(database)
%[Nodes, Edges, Images,Labellings] = Load_TarragonaRotationZoom(database)
load(database);
for graph = 1:size(DATABASE.elements,2)
    Nodes{graph}=DATABASE.elements{graph}.desc;
    Edges{graph}=DATABASE.elements{graph}.edges;
    Images{graph}=DATABASE.elements{graph}.Image;
    Labellings{graph}=DATABASE.elements{graph}.matching;
    Pixels{graph}=DATABASE.elements{graph}.loc;
end
end

