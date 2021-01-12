% ***** Test Classification DB ****
clear;
clc;
close all;

%% Execution parameters
SamplesKv = 8;
SamplesKe = 40;
Database_Name='LETTERLOW';
num_test_graphs=10;%0; % Number of test
MinKv=0.1; MaxKv=0.5;
MinKe=0.1; MaxKe=3;

%% Execution parameters
SamplesKv = 8;
SamplesKe = 40;
Database_Name='LETTERMED';
num_test_graphs=10;%0; % Number of test
MinKv=0.1; MaxKv=1000;
MinKe=0.1; MaxKe=1000;

%% Execution parameters
SamplesKv = 8;
SamplesKe = 40;
Database_Name='LETTERHIGH';
num_test_graphs=10;%0; % Number of test
MinKv=0.1; MaxKv=100;
MinKe=0.1; MaxKe=100;

%% Execution parameters
SamplesKv = 40;
SamplesKe = 40;
Database_Name='ROTATIONZOOM';
num_test_graphs=1;%0; % Number of test
MinKv=0.01; MaxKv=0.1;
MinKe=0.01; MaxKe=0.1;

%% Execution parameters
SamplesKv = 40;
SamplesKe = 40;
Database_Name='HOUSEHOTEL';
num_test_graphs=1;%0; % Number of test
MinKv=0.8; MaxKv=3.5;
MinKe=0.8; MaxKe=3.5;

%% Execution parameters
SamplesKv = 40;
SamplesKe = 40;
Database_Name='SAGRADAFAMILIA3D';
num_test_graphs=1;%0; % Number of test
MinKv=0.5; MaxKv=3;
MinKe=0.5; MaxKe=3;

%% Execution parameters
SamplesKv = 10;
SamplesKe = 10;
Database_Name='PALMPRINT';
num_test_graphs=1;%0; % Number of test
MinKv=1; MaxKv=40;
MinKe=1; MaxKe=10;

%% End parameters
disp(Database_Name);
display_flag=0; % Show mapping (1)  or not (0)
Kv=MinKv:(MaxKv-MinKv)/(SamplesKv-1):MaxKv;
Ke=MinKe:(MaxKe-MinKe)/(SamplesKe-1):MaxKe;
AH=zeros(length(Kv),length(Ke));
load(strcat(Database_Name,'.mat'));  
for i=1:length(Kv)
    disp(i);
    for j=1:length(Ke)
        [i j]
        %[CA(i,j),DI(i,j),class,classification_runtime,Dist_Matrix] = Classify_Database_Fingerprint(Database.Learning,Database.Test,WWxy(i),WWa(j),Wtb,display_flag,num_test_graphs);
        [AH(i,j),average_runtime,hamming] = hammingDatabase_Degree(Database_Name,Database,Kv(i),Ke(j),num_test_graphs);
    end
end

% Saving results
 save(strcat(Database_Name,'_Surface_Classification_Hamming'));
 %AH  
 Show_Surface_Classify_Database