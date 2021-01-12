function [w , Kv , Ke] = Linear_Coefficients_nD (Data,Class)
MdlLinear=fitcdiscr(Data,Class);
n = MdlLinear.Coeffs(1,2).Const;
m = MdlLinear.Coeffs(1,2).Linear;
%% Data: x,y,z,...g,t
% m(1)·x+m(2)·y+...+m(end-1)·g+m(end)·t+n=0
Kv=n;
Ke=m(end);
w=m(1:end-1)';
% w1x + w2*y + ... + wN*g + Ke*t + Kv = 0

%% Plot 3D figure
if size(Data,2) == 3
    X1=Data(Class==1,1);
    Y1=Data(Class==1,2);
    Z1=Data(Class==1,3);
    X2=Data(Class==-1,1);
    Y2=Data(Class==-1,2);
    Z2=Data(Class==-1,3);
    hold on

    zmin=min(Data(:,3));
    zmax=max(Data(:,3));
    ymin=min(Data(:,2));
    ymax=max(Data(:,2));
    [yy,zz]=meshgrid([ymin ymax],[zmin zmax]);

    xx=-(w(2)*yy+Ke*zz+Kv)/w(1);
    surf(xx,yy,zz);

    plot3(X1,Y1,Z1,'r+');
    plot3(X2,Y2,Z2,'b*');
    xlabel('S1');
    ylabel('S2');
    zlabel('Se');
end
% if size(Data,2) == 4
%     X1=Data(Class==1,2);
%     Y1=Data(Class==1,3);
%     Z1=Data(Class==1,4);
%     X2=Data(Class==-1,2);
%     Y2=Data(Class==-1,3);
%     Z2=Data(Class==-1,4);
%     hold on
% 
%     zmin=min(Data(:,4));
%     zmax=max(Data(:,4));
%     ymin=min(Data(:,3));
%     ymax=max(Data(:,3));
%     [yy,zz]=meshgrid([ymin ymax],[zmin zmax]);
% 
%     xx=-w(3)*yy-Ke*zz-Kv;
%     surf(xx,yy,zz);
% 
%     plot3(X1,Y1,Z1,'r+');
%     plot3(X2,Y2,Z2,'b*');
%     xlabel('S2');
%     ylabel('S3');
%     zlabel('Se');
%     
%     figure;
%     X1=Data(Class==1,1);
%     Y1=Data(Class==1,2);
%     Z1=Data(Class==1,4);
%     X2=Data(Class==-1,1);
%     Y2=Data(Class==-1,2);
%     Z2=Data(Class==-1,4);
%     hold on
% 
%     zmin=min(Data(:,4));
%     zmax=max(Data(:,4));
%     ymin=min(Data(:,2));
%     ymax=max(Data(:,2));
%     [yy,zz]=meshgrid([ymin ymax],[zmin zmax]);
% 
%     xx=-w(2)*yy-Ke*zz-Kv;
%     surf(xx,yy,zz);
% 
%     plot3(X1,Y1,Z1,'r+');
%     plot3(X2,Y2,Z2,'b*');
%     xlabel('S1');
%     ylabel('S2');
%     zlabel('Se');
%    
% end


end
