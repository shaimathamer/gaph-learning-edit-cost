function [file2update,dx_final,dy_final,dang_finaladjust]= houghTransform(file1,file2)

%The inputs are:
%file1 and file2 are the ones that we compare. File 1 is the one on the DB
%and file 2 is the "found" palmprint. 

%The outputs are:
%file2update: the minutiae with the corresponding transformation of file2 
%which is also written in a file named hough.txt
%dx_final: displacemet in the x axis
%dy_final: displacemet in the y axis
%dang_finaladjust: rotation for the matching to take place (adjust means
%that an adjustment was made to do the exact rotation for a 1 degree step.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Hough%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
discret_pos = 1;         %analize hough for every position
discret_ang = 10;        %analize on a step of 10 deg
umbral_ang=5; 
resize=5;               % Serratosa

A=file1;
for i=1:size(A,1)
    A(i,1)=A(i,1)/resize;
    A(i,2)=A(i,2)/resize;
end
B=file2;
for i=1:size(B,1)
    B(i,1)=B(i,1)/resize;
    B(i,2)=B(i,2)/resize;   
end

imgrows = 2040/resize;
imgcols = 2040/resize;         %size of the image od Tsinghua database is 2040x2040 px

        
A = abs(A);
B = abs(B);             %turn negative angles into positive
[arows,acols]=size(A);
[brows,bcols]=size(B);
houghmatrixpp = zeros((imgrows/discret_pos),(imgcols/discret_pos),((360)/discret_ang));
houghmatrixnp = zeros((imgrows/discret_pos),(imgcols/discret_pos),((360)/discret_ang));
houghmatrixpn = zeros((imgrows/discret_pos),(imgcols/discret_pos),((360)/discret_ang));
houghmatrixnn = zeros((imgrows/discret_pos),(imgcols/discret_pos),((360)/discret_ang));

discret = [-5,-4,-3,-2,-1,0,1,2,3,4,5; 0,0,0,0,0,0,0,0,0,0,0];

for i=1:brows;
   for j=1:arows;
       contang = 10;
       contx = 0;
       conty = 0;
%        flag = 0;
       
        tipoa = A(j,4);
        tipob = B(i,4);
        if tipoa == tipob
            for k=1:(360/discret_ang)
            
            temp_ang = B(i,3)+contang;
            if temp_ang>360
                temp_ang = temp_ang - 360;
            else
            end
           

            if min(abs(temp_ang-A(j,3)),(360-abs(temp_ang-A(j,3))))<=umbral_ang
            
%             if contang == 360
%                 contang2 = 0;
%             else
%                 contang2 = contang;
%             end
                
            matriz1(1,1)=A(j,1);
            matriz1(2,1)=A(j,2);
           
            matriz2(1,1)= cos(0*(pi/180));
            matriz2(1,2)= -sin(0*(pi/180));
            matriz2(2,1)= sin(0*(pi/180));
            matriz2(2,2)= cos(0*(pi/180));
            matriz3(1,1)=B(i,1);
            matriz3(2,1)=B(i,2);
            
            matriz4 = matriz1 - matriz2 * matriz3;
            dx = matriz4(1,1);
            dy = matriz4(2,1);
            
            
            if dx<imgrows && dx>-imgrows
                if dy<imgcols && dy>-imgcols
          
            
                        for m = 1:imgrows/discret_pos;
                             if abs(dx)<(discret_pos*m) && abs(dx)>=(discret_pos*(m-1));
                                contx = m;    
                             else
                             end
                        end
                        for m=1:imgcols/discret_pos;
                             if abs(dy)<(discret_pos*m) && abs(dy)>=(discret_pos*(m-1));
                                conty = m;    
                             else
                             end
                        end
                        
%                         if flag == 0;
                        if dx>=0 && dy>=0 && contang~=0
                        houghmatrixpp(contx,conty,(contang/discret_ang)) = houghmatrixpp(contx,conty,(contang/discret_ang)) + 1;
                            for n=1:11
                                if temp_ang>=A(j,3)
                                    if discret(1,n)==min(abs(temp_ang-A(j,3)),(360-abs(temp_ang-A(j,3))));
                                        discret(2,n)=discret(2,n)+1;
                                        flag1=1;%%
                                    else
                                        flag2=1;%%
                                        wtf = min(abs(temp_ang-A(j,3)),(360-abs(temp_ang-A(j,3))));%%
                                        wtftempang = temp_ang;%%
                                        wtfaj3 = A(j,3);%
                                    end
                                else
                                    if discret(1,n)==min((temp_ang-A(j,3)),(360+(temp_ang-A(j,3))));
                                        discret(2,n)=discret(2,n)+1;
                                        flag3=1;%%
                                    else
                                        flag4=1;%%
                                        wtf = min((temp_ang-A(j,3)),(360+(temp_ang-A(j,3))));%%
                                        wtftempang = temp_ang;%%
                                        wtfaj3 = A(j,3);%%
                                    end
                                end
                            end
%                         flag = 1;
                        else
                        if dx>=0 && dy<0 && contang~=0
                        houghmatrixpn(contx,conty,(contang/discret_ang)) = houghmatrixpn(contx,conty,(contang/discret_ang)) + 1;
                            for n=1:11
                                if temp_ang>=A(j,3)
                                    if discret(1,n)==min(abs(temp_ang-A(j,3)),(360-abs(temp_ang-A(j,3))));
                                        discret(2,n)=discret(2,n)+1;
                                        flag5=1;%%
                                    else
                                        flag6=1;%%
                                    end
                                else
                                    if discret(1,n)==min((temp_ang-A(j,3)),(360+(temp_ang-A(j,3))));
                                        discret(2,n)=discret(2,n)+1;
                                        flag7=1;%%
                                    else
                                        flag8=1;%%
                                    end
                                end
                            end
%                         flag = 1;
                        else
                        if dx<0 && dy>=0 && contang~=0
                        houghmatrixnp(contx,conty,(contang/discret_ang)) = houghmatrixnp(contx,conty,(contang/discret_ang)) + 1;
                            for n=1:11
                                if temp_ang>=A(j,3)
                                    if discret(1,n)==min(abs(temp_ang-A(j,3)),(360-abs(temp_ang-A(j,3))));
                                        discret(2,n)=discret(2,n)+1;
                                        flag9=1;%%
                                    else
                                        flag10=1;%%
                                    end
                                else
                                    if discret(1,n)==min((temp_ang-A(j,3)),(360+(temp_ang-A(j,3))));
                                        discret(2,n)=discret(2,n)+1;
                                        flag11=1;%%
                                    else
                                        flag12=1;%%
                                    end
                                end
                            end
%                         flag = 1;
                        else
                        if dx<0 && dy<0 && contang~=0
                        houghmatrixnn(contx,conty,(contang/discret_ang)) = houghmatrixnn(contx,conty,(contang/discret_ang)) + 1;
                            for n=1:11
                                if temp_ang>=A(j,3)
                                    if discret(1,n)==min(abs(temp_ang-A(j,3)),(360-abs(temp_ang-A(j,3))));
                                        discret(2,n)=discret(2,n)+1;
                                        flag13=1;%%
                                    else
                                        flag14=1;%%
                                    end
                                else
                                    if discret(1,n)==min((temp_ang-A(j,3)),(360+(temp_ang-A(j,3))));
                                        discret(2,n)=discret(2,n)+1;
                                        flag15=1;%%
                                    else
                                        flag16=1;%%
                                    end
                                end
                            end
%                         flag = 1;
                        else
                        end
                        end
                        end
                        end
%                         else
%                         end
                      
                else 
                end
            else
            end  
             
                        
                        
             
            contang = contang + discret_ang;              
            else
            contang = contang + discret_ang;   
            end
            end
        else     
        end
        
   end
end


C(1,1) = max(max(max(houghmatrixpp)));
C(1,2) = max(max(max(houghmatrixpn)));
C(1,3) = max(max(max(houghmatrixnp)));
C(1,4) = max(max(max(houghmatrixnn)));

max_houghmatrix = max(C);

if max_houghmatrix == C(1,1)
    for i=1:(imgrows/discret_pos)
        for j=1:(imgcols/discret_pos)
            for k=1:((360)/discret_ang)
            
            if houghmatrixpp(i,j,k) == max_houghmatrix
           
            dx_final = resize*(i-1);
            dy_final = resize*(j-1);
            dang_final = k*10;
            
            else
            end
            
            end
        end
    end

else
if max_houghmatrix == C(1,2)
    for i=1:(imgrows/discret_pos)
        for j=1:(imgcols/discret_pos)
            for k=1:((360)/discret_ang)
            
            if houghmatrixpn(i,j,k) == max_houghmatrix
           
            dx_final = resize*(i-1);
            dy_final = -resize*(j-1);
            dang_final = k*10;
            
            else
            end
            
            end
        end
    end    

    else
if max_houghmatrix == C(1,3)
    for i=1:(imgrows/discret_pos)
        for j=1:(imgcols/discret_pos)
            for k=1:((360)/discret_ang)
            
            if houghmatrixnp(i,j,k) == max_houghmatrix
           
            dx_final = -resize*(i-1);
            dy_final = resize*(j-1);
            dang_final = k*10;
            
            else
            end
            
            end
        end
    end    
    
else

    for i=1:(imgrows/discret_pos)
        for j=1:(imgcols/discret_pos)
            for k=1:((360)/discret_ang)
            
            if houghmatrixnn(i,j,k) == max_houghmatrix
           
            dx_final = -resize*(i-1);
            dy_final = -resize*(j-1);
            dang_final = k*10;
            
            else
            end
            
            end
        end
    end 
    
    
end
end
end
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%updating second file%%%%%%%%%%%%%%%%%%%%%%%%%%
A=file1;
B=file2;
A = abs(A);
B = abs(B); 
[arows,acols]=size(A);
[brows,bcols]=size(B);

discret2 = zeros(1,11);

for n=1:11
    discret2(1,n) = discret(2,n);
end

maxdiscret2 = max(discret2);

for n=1:11
    if discret(2,n)==maxdiscret2
        adjust = discret(1,n);
    else
    end
end

file2update = zeros(1,5);

for i=1:brows
    
    file2update(i,1) = B(i,1)+ dx_final;
        if file2update(i,1)>2040
            file2update(i,1) = 2040;
        else
        end
    file2update(i,2) = B(i,2)+ dy_final;
        if file2update(i,2)>2040
            file2update(i,2) = 2040;
        else
        end
    file2update(i,3) = B(i,3)+ (dang_final-adjust);
        if file2update(i,3)>360
            file2update(i,3) = file2update(i,3)-360;
        else
        end
    
    file2update(i,3) = -file2update(i,3);
    file2update(i,4) = B(i,4);
    file2update(i,5) = B(i,5);
    B(i,3) = -B(i,3);
    

end


for j=1:arows
    A(j,3) = -A(j,3);
end

if dang_final-adjust==360
    dang_finaladjust=0;
else
    dang_finaladjust=(dang_final-adjust);
end

% dlmwrite('file2update.txt', file2update);