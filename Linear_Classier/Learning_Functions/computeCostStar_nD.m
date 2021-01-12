function cost = computeCostStar_nD(G1, G2, i, j)
%% Compute the cost of the external nodes of a star given without labelling
NeighboursA=G1.nodes(G1.edges(i,:)>0,:);
a=size(NeighboursA,1);
NeighboursB=G2.nodes(G2.edges(j,:)>0,:);
b=size(NeighboursB,1);

T=size(G1.nodes,2);
C=zeros(a,b,T);
  for i=1:a
    for j=1:b      
        C(i,j,:)=abs(NeighboursA(i,:)-NeighboursB(j,:));
    end
  end
cost=zeros(T,1);
for t=1:T
    lab=Hungarian(C(:,:,t));
    cost(t)=sum(sum(lab.*C(:,:,t)));
end

end