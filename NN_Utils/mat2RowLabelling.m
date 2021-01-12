function [ rowLabelling ] = mat2RowLabelling( matLabelling )
%ROWLABELLING2MAT Transforms a row labelling to a matrix labelling

rowLabelling=zeros(1,size(matLabelling,1));

for i=1:size(matLabelling,1)
    pos=find(matLabelling(i,:));
    if (~isempty(pos))
        rowLabelling(i)=pos;
    else
        rowLabelling(i)=0;
    end
end

