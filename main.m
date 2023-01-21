
%% Image Enhancment
clear;
clc;
close all;
warning('off');

% Loading
img=imread('sample2.jpg');

%preprocess
img=im2double(img);
gray=rgb2gray(img);

% Reshaping image to vector
X=gray(:);

%define cost
%view original
figure;
imshow(img); 
title('Original');
figure;
imhist(img);
title('Original hist');

%define cost
%########## Algorithm ###########

%% Starting Cluster
k = 6; 
CostF=@(m)CostF(m, X);   
VarSize=[k size(X,2)];           
nVar=prod(VarSize);             
VarMin= repmat(min(X),k,1);      
VarMax= repmat(max(X),k,1);      

% Parameters
MaxIt = 100;           
nPop = 5;           
gamma = 0.001;                          % Abs
beta0 = 0.001;                          % Attr 
alpha = 0.001;                            % Mutatc
alpha_damp = 0.9;                      % DR
delta = 0.01*(VarMax-VarMin);           % Uni Mutate range
m = 10;
if isscalar(VarMin) && isscalar(VarMax)
dmax = (VarMax-VarMin)*sqrt(nVar);
else
dmax = norm(VarMax-VarMin);
end

%############ Algorithm ###########

%% Start
%% Empty fire Structure
fire.Position = [];
fire.Cost = [];
fire.Out = [];

%% Initialize Population Array
pop = repmat(fire, nPop, 1);

%% Initialize Best Solution Ever Found
BestSol.Cost = inf;

%% Create Initials
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost, pop(i).Out] = CostF(pop(i).Position);
if pop(i).Cost <= BestSol.Cost
BestSol = pop(i);
end
end

%% Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

%% Main Loop
for it = 1:MaxIt
newpop = repmat(fire, nPop, 1);
for i = 1:nPop
newpop(i).Cost = inf;
for j = 1:nPop
if pop(j).Cost < pop(i).Cost
rij = norm(pop(i).Position-pop(j).Position)/dmax;
beta = beta0.*exp(-gamma.*rij^m);

%% two types
e = delta.*unifrnd(-1, +1, VarSize);

newsol.Position = pop(i).Position ...
+ beta.*rand(VarSize).*(pop(j).Position-pop(i).Position) ...
+ alpha.*e;
newsol.Position = max(newsol.Position, VarMin);
newsol.Position = min(newsol.Position, VarMax);
[newsol.Cost, newsol.Out] = CostF(newsol.Position);
if newsol.Cost <= newpop(i).Cost
newpop(i) = newsol;
if newpop(i).Cost <= BestSol.Cost
BestSol = newpop(i);

end
end
end
end
end

%% Merge
pop = [pop 
    newpop];  

%% Sort
[~, SortOrder] = sort([pop.Cost]);
pop = pop(SortOrder);

%% Truncate
pop = pop(1:nPop);

%% Store the cost
BestCost(it) = BestSol.Cost;
disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);

%% Damping
alpha = alpha*alpha_damp;
end
%% final
Th=sort(BestSol.Position);
enhanced = imadjust(img,[Th(1) Th(2) Th(3); Th(4) Th(5) Th(6)]);


%% output image
%% enhanced=Algor(img);
figure;
imshow(enhanced);
title('Enhanced image');
figure;
imhist(enhanced);
title('Enhanced hist');
%% save output
imwrite(enhanced,"enhanced.jpg");
%% imwrite(enhanced,"enhanced.png");

%% montage or colllage
figure;
subplot(1,2,1);
imshow(img); title('Original image');
subplot(1,2,2)
imshow(enhanced,[]);title('Enhanced image');

%parameters evaluation for input and enhanced image
gg=getImagepara(img,enhanced);


%% Visualise cost update

% figure;
% plot(BestCost,'k', 'LineWidth', 1);
% xlabel('ITR');
% ylabel('Cost Update');
% ax = gca; 
% ax.FontSize = 12; 
% ax.FontWeight='bold';
% set(gca,'Color','c')
% grid on;

%% apply clahe
t=getCLAHE(enhanced);


%% apply k-means
xx=getkmean(enhanced);






