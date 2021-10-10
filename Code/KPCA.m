dataset = readtable('Meter-B.txt', 'ReadVariableNames', false);
data = table2array(dataset);

markers = ["k.", "ro", "y"];
% Separation of prediction set
X = data(:, 1:51);
Y = data(:, 52);
X = zscore(X);

idx1 = find(Y==1);
idx2 = find(Y==2);
idx3 = find(Y==3);

% Computing Regular PCA
[PCALoadings, PCAScores] = pca(X);

figure;
title("PCA Biplot")
hold on
for i = 1:length(Y)
    plot(PCAScores(idx1, 1), PCAScores(idx1, 2), markers(1));
    plot(PCAScores(idx2, 1), PCAScores(idx2, 2), markers(2));
    plot(PCAScores(idx3, 1), PCAScores(idx3, 2), markers(3));
    
end



    
% Cross validation (train: 70%, test: 30%)
%cv = cvpartition(size(data, 1), 'HoldOut', 0.3);
%idx = cv.test;

%Train = data(~idx,:);
%Test = data(idx,:);
%Train = zscore(Train);          % Standardaization

%xTrain = zscore(Train(:, 1:51));
%yTrain = Train(:, 52);
%xTest = Test(:, 1:51);
%yTest = Test(:, 52);
