clear all
close all 
clc
%% load datas
[~,SheetNames]  = xlsfinfo('TPStat');
Y1 = xlsread('TPStat', SheetNames{1});
Y2 = xlsread('TPStat', SheetNames{2});
Y1_x = xlsread('TPStat', SheetNames{3});

%% question 1, moyenne et std
Y1_moy = mean(Y1);
Y2_moy = mean(Y2);

sigma1 = std(Y1);
sigma2 = std(Y2);
%% 2(a), Lois par graphe
% histogram
Nbins = 10;
[N1,edges1] = histcounts(Y1,Nbins);
figure
histogram(Y1,Nbins);
title('histogram of Y1');

[N2,edges2] = histcounts(Y2,Nbins);
figure
histogram(Y2,Nbins);
title('histogram of Y2');

% qq-plot
figure 
qqplot(Y1);
title('qq-plot of Y1');
figure 
qqplot(Y2);
title('qq-plot of Y2');

%% 2(b), lois par test
% test Y1

