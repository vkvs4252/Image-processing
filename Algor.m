




function enhanced=Algor(X)

%% Starting Cluster
k = 6; 
%CostF=@(m)CostF(m, X);   
VarSize=[k size(X,2)];           
nVar=prod(VarSize);             
VarMin= repmat(min(X),k,1);      
VarMax= repmat(max(X),k,1);      

% Parameters
MaxIt = 20;           
nPop = 4;           
gamma = 1;                               %Abs
beta0 = 4;                              % Attr 
alpha = 10;                              % Mutatc
alpha_damp = 0.10;                      % DR
delta = 0.10*(VarMax-VarMin);           % Uni Mutate range
m = 1000;
if isscalar(VarMin) && isscalar(VarMax)
dmax = (VarMax-VarMin)*sqrt(nVar);
else
dmax = norm(VarMax-VarMin);
end

%############################ Algorithm ###########

% Start
% Empty fire Structure
fire.Position = [];
fire.Cost = [];
fire.Out = [];

% Initialize Population Array
pop = repmat(fire, nPop, 1);

% Initialize Best Solution Ever Found
BestSol.Cost = inf;

% Create Initials
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost, pop(i).Out] = CostF(pop(i).Position);
if pop(i).Cost <= BestSol.Cost
BestSol = pop(i);
end
end

% Hold Best Cost Values
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

%two types
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


% Merge
pop = [pop newpop];  

% Sort
[~, SortOrder] = sort([pop.Cost]);
pop = pop(SortOrder);

% Truncate
pop = pop(1:nPop);

% Store the cost
BestCost(it) = BestSol.Cost;
disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);

% Damping
alpha = alpha*alpha_damp;
end
%final
Th=sort(BestSol.Position);
enhanced = imadjust(img,[Th(1) Th(2) Th(3); Th(4) Th(5) Th(6)]);

    