function [m, n] = Linear_Coefficients_2D (Data,Class,Imposed_Kv,Imposed_Ke)
MdlLinear=fitcdiscr(Data,Class);
K = MdlLinear.Coeffs(1,2).Const;
L = MdlLinear.Coeffs(1,2).Linear;
m=-L(1)/L(2); %X2=m·X1+n
n=-K/L(2); %X2=m·X1+n

%% Plot figure
X1=Data(Class==-1,1);
Y1=Data(Class==-1,2);
X2=Data(Class==1,1);
Y2=Data(Class==1,2);
plot(X1,Y1,'r+');
hold on;
plot(X2,Y2,'b*');
xMin_line=min(Data(:,1));
yMin_line=m*min(Data(:,1))+n;
xMax_line=max(Data(:,1));
yMax_line=m*max(Data(:,1))+n;
plot([xMin_line; xMax_line], [yMin_line; yMax_line],'b');

if Imposed_Kv >-10000
%% Plot Imposed values
xMin_line=min(Data(:,1));
yMin_line=Imposed_Kv*min(Data(:,1))+Imposed_Ke;
xMax_line=max(Data(:,1));
yMax_line=Imposed_Kv*max(Data(:,1))+Imposed_Ke;
plot([xMin_line; xMax_line], [yMin_line; yMax_line],'r'),
end
end
