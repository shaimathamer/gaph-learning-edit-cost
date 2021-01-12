function [trainSet, valSet, testSet] = loadHorseDatabase(databaseName, distFrames)
    %% loading database info
    [P] = loadDataSyntheticInfo(databaseName);

    totalFrames = size(P,2);

    % Building the pairs taking into account the distance (90, 80, 70...)
    for iFrame = 1:totalFrames - distFrames
        PAIRS{iFrame}.E1 = P{iFrame};
        PAIRS{iFrame}.E1.databaseName = databaseName;
        PAIRS{iFrame}.E1.numGraph = iFrame;
        PAIRS{iFrame}.E2 = P{iFrame + distFrames};
        PAIRS{iFrame}.E2.databaseName = databaseName;
        PAIRS{iFrame}.E2.numGraph = iFrame + distFrames;
    end
   
    
    
    % Reading the TRAINING test (note there are ref., val. and test sets)
    trainSet = [];
    for iPair = 1:3:totalFrames - distFrames
        P1 = PAIRS{iPair}.E1;
        P2 = PAIRS{iPair}.E2;
        L = eye(size(P1.nodes,1));
        trainSet{end + 1}.P1 = P1;
        trainSet{end}.P2 = P2;
        trainSet{end}.L = L;
    end
    
    % Reading the VALIDATION test (note there are ref., val. and test sets)
    valSet = [];
    for iPair = 2:3:totalFrames - distFrames
        P1 = PAIRS{iPair}.E1;
        P2 = PAIRS{iPair}.E2;
        L = eye(size(P1.nodes,1));
        valSet{end + 1}.P1 = P1;
        valSet{end}.P2 = P2;
        valSet{end}.L = L;
    end
    
    % Reading the TEST test (note there are ref., val. and test sets)
    testSet = [];
    for iPair = 3:3:totalFrames - distFrames
        P1 = PAIRS{iPair}.E1;
        P2 = PAIRS{iPair}.E2;
        L = eye(size(P1.nodes,1));
        testSet{end + 1}.P1 = P1;
        testSet{end}.P2 = P2;
        testSet{end}.L = L;
    end    
end