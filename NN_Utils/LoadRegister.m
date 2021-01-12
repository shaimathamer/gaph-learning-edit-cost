function [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,Set)

% The number of Registers is equal to the number of total correspondences
% contained in the database. This function only works if the database is
% balanced and contains all possible correspondences for each pair of
% graphs

%% Load the register
if strcmp(Set,'Learning')==1;
    if length(Database.Learning)==1
    error('The set is empty');
    else
    if Register>length(Database.Learning)*length(Database.Learning{1,1}.Correspondences);
    error('The register queried exceeds the size of the set');
    else
    Index_G=ceil(Register/(length(Database.Learning{1,1}.Correspondences)));
    j=round(mod(Register/length(Database.Learning{1,1}.Correspondences),1)*length(Database.Learning{1,1}.Correspondences));
    if j==0
        j=length(Database.Learning{1,1}.Correspondences);
    else
    end
    f=Database.Learning{1,Index_G}.Correspondences{1,j}.Mappings;
    G=Database.Learning{1,Index_G}.Graph;
    Index_Gprime=Database.Learning{1,Index_G}.Correspondences{1,j}.InputGraph;
    Gprime=Database.Learning{1,Index_Gprime}.Graph;
    C=Database.Learning{1,Index_G}.Class;
    end
    end
else
if strcmp(Set,'Test')==1;
    if length(Database.Test)==1
    error('The set is empty');
    else
    if Register>length(Database.Test)*length(Database.Test{1,1}.Correspondences);
    error('The register queried exceeds the size of the set');
    else
    Index_G=ceil(Register/(length(Database.Test{1,1}.Correspondences)));
    j=round(mod(Register/length(Database.Test{1,1}.Correspondences),1)*length(Database.Test{1,1}.Correspondences));
    if j==0
        j=length(Database.Test{1,1}.Correspondences);
    else
    end
    f=Database.Test{1,Index_G}.Correspondences{1,j}.Mappings;
    G=Database.Test{1,Index_G}.Graph;
    Index_Gprime=Database.Test{1,Index_G}.Correspondences{1,j}.InputGraph;
    Gprime=Database.Test{1,Index_Gprime}.Graph;
    C=Database.Test{1,Index_G}.Class;
    end
    end
else
    if length(Database.Validation)==1
    error('The set is empty');
    else
    if Register>length(Database.Validation)*length(Database.Validation{1,1}.Correspondences);
    error('The register queried exceeds the size of the set');
    else
    Index_G=ceil(Register/(length(Database.Validation{1,1}.Correspondences)));
    j=round(mod(Register/length(Database.Validation{1,1}.Correspondences),1)*length(Database.Validation{1,1}.Correspondences));
    if j==0
        j=length(Database.Validation{1,1}.Correspondences);
    else
    end
    f=Database.Validation{1,Index_G}.Correspondences{1,j}.Mappings;
    G=Database.Validation{1,Index_G}.Graph;
    Index_Gprime=Database.Validation{1,Index_G}.Correspondences{1,j}.InputGraph;
    Gprime=Database.Validation{1,Index_Gprime}.Graph;
    C=Database.Validation{1,Index_G}.Class;
    end
    end
end
end
end