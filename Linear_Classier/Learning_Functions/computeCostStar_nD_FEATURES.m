function cost = computeCostStar_nD_FEATURES(G1, G2, i, j,Features_Distance_nD)
%% Compute the cost of the external nodes of a star given without labelling
ii=find(G1.edges(i,:)>0);
jj=find(G2.edges(j,:)>0);
a=length(ii);
b=length(jj);

T=size(G1.nodes,2);
C=zeros(T,a,b);
  for i=1:a
    for j=1:b
        C(:,i,j)=Features_Distance_nD(:,ii(i),jj(j));
    end
  end
cost=zeros(T,1);
for t=1:T
    CC=zeros(size(C,2),size(C,3));
    for i=1:size(C,2)
        CC(i,:)=C(t,i,:);
    end
    lab=Hungarian(CC);
    cost(t)=sum(sum(lab.*CC));
end

%% old method
% CC=zeros(a,b);  
%  for i=1:a
%     for j=1:b
%         CC(i,j)=sum(C(:,a,b));
%     end
%  end
% lab=Hungarian(CC);
% cost=zeros(T,1);
% for i=1:a
%    for j=1:b
%        if lab(i,j)==1
%             for t=1:T
%                 cost(t)=cost(t)+C(t,i,j);
%             end
%        end
%     end
% end
%%

end