dataset = readtable('Meter-B.txt', 'ReadVariableNames', false);
data = table2array(dataset);

markers = ["ro", "k.", "go"];
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


% Fitting the model
kerneltype = ' gaussian';
kernel = Kernel('type', 'gaussian', 'gamma', 2);
%kernel = Kernel('type', 'polynomial', 'degree', 2);
%kernel = Kernel('type', 'linear');
%kernel = Kernel('type', 'sigmoid', 'gamma', 2);
%kernel = Kernel('type', 'laplacian', 'gamma', 2);

parameter = struct('numComponents',2, ...
                    'kernelFunc', kernel);
kpca = KernelPCA(parameter);
model = kpca.train(X);


KPCAScores = kpca.score;

figure
title(strcat("KPCA Biplot", kerneltype));
hold on
for i = 1:length(Y)
    plot(KPCAScores(idx1, 1), KPCAScores(idx1, 2), markers(1));
    plot(KPCAScores(idx2, 1), KPCAScores(idx2, 2), markers(2));
    plot(KPCAScores(idx3, 1), KPCAScores(idx3, 2), markers(3));
end


