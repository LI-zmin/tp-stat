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
%histogram
edgs = [Y1_moy-3*sigma1, Y1_moy-2*sigma1, Y1_moy-sigma1, Y1_moy, Y1_moy+sigma1, Y1_moy+2*sigma1, Y1_moy+3*sigma1];
N1 = histcounts(Y1,edgs);
figure
histogram(Y1,edgs);
title('histogram of Y1');
% 
edgs = [Y2_moy-3*sigma2, Y2_moy-2*sigma2, Y2_moy-sigma2, Y2_moy, Y2_moy+sigma2, Y2_moy+2*sigma2, Y2_moy+3*sigma2];
N2 = histcounts(Y2,edgs);
figure
histogram(Y2,edgs);
title('histogram of Y2');

% qq-plot
figure 
qqplot(Y1);
title('qq-plot of Y1');
% figure 
% qqplot(Y2);
% title('qq-plot of Y2');

%% 2(b), lois par test
% test Y1, supposons Y1 ~ N(Y1_moy, sigma1^2)

% p1 = P(Y1<mu-2*sigma), p2 = P(mu-2sigma<Y1<mu-sigma) ....
% edg_tho_1 est les edges du loi normales thorique 
edg_tho_1 = [Y1_moy-2*sigma1, Y1_moy-sigma1, Y1_moy, Y1_moy+sigma1, Y1_moy+2*sigma1];
p1 = cdf('norm',edg_tho_1(1), Y1_moy,sigma1);
P1 =[];
P1(1) = p1;
for i = 1:length(edg_tho_1)-1
    P1(i+1) = cdf('norm',edg_tho_1(i+1), Y1_moy,sigma1)-cdf('norm',edg_tho_1(i), Y1_moy,sigma1);
end
P1(length(edg_tho_1)+1) = p1;
% calculons les npj
NP = P1*length(Y1);
nb_inf5 = sum(NP<5);

%% calcule Z 
% merger les classes
for i = 2:5
    new_N1(i-1) = N1(i);
    new_NP(i-1) = NP(i);
end
new_N1(1) = new_N1(1)+N1(1);
new_N1(4) = new_N1(4)+N1(6);
new_NP(1) = new_NP(1)+NP(1);
new_NP(4) = new_NP(4)+NP(6);
% calcule Z
Z = 0;
for i = 1:4
    Z = Z + (new_N1(i)-new_NP(i))^2/NP(i);
end
