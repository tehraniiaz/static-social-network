%% Program Start
clc;
clear;
close all;
%% Problem  Definition
problem=createproblem();
n=problem.n;
nvar=n;  % Number  Of  Decision Variable
varmin=0;  % Lower  Bound  Of  Decision Variable
varmax=1;  % Upper  Bound  Of  Decision Variable
costfunction=@(x)    mycost(x,problem);  % Cost  Function
%% GA  Parameters
npop=50;  % Number  Of  Population
maxiteration=100; % Maximum  Of  Iteration
ts=5;  % Tournament  Size
pc=0.8;  % Probability  Of  Crossover
nc=2*round(pc*npop/2);  % Number  Of  Crossover
pm=0.2;  % Probability  Of  Mutation
nm=round(pm*npop);  % Number  Of  Mutation
mu=0.6;  % Mutation Rate
nmu=round(mu*nvar);  % Number  Of  Mutation
sigma=0.1*(varmax-varmin);  % Step  Size
%% Initialization Step
s=questdlg('Please  Select  Method?','Selection..','Random','Roulettewheel','Tournament','Tournament');
empty_individual.position=[];
empty_individual.cost=[];
empty_individual.output=[];
pop=repmat(empty_individual,npop,1);
bestsol.cost=inf;
for  i=1:npop
   pop(i).position=unifrnd(varmin,varmax,1,nvar);
   [pop(i).cost,pop(i).output]=costfunction(pop(i).position);
   if  pop(i).cost<bestsol.cost
      bestsol=pop(i);
   end
end
%% Main  Loop
bestcost=zeros(maxiteration,1);
for  iteration=1:maxiteration
   % Crossover
   popc=repmat(empty_individual,nc/2,2);
   for  i=1:nc/2
      % Select  Parents
      if  strcmp(s,'Random')
        i1=randi([1 npop]);
        i2=randi([1 npop]);
      elseif  strcmp(s,'Roulettewheel')
          f=[pop.cost];
          F=1./(abs(f)+1);
          p=F./sum(F);
          i1=roulettewheel(p);
          i2=roulettewheel(p);
      elseif  strcmp(s,'Tournament')
          i1=tournamentselection(pop,ts);
          i2=tournamentselection(pop,ts);
      end
      % Apply  Crossover
      [popc(i,1).position,popc(i,2).position]=crossover(pop(i1).position,pop(i2).position);
      % Bounded
      popc(i,1).position=max(popc(i,1).position,varmin);
      popc(i,1).position=min(popc(i,1).position,varmax);
      popc(i,2).position=max(popc(i,2).position,varmin);
      popc(i,2).position=min(popc(i,2).position,varmax);
      % Evaluation
      [popc(i,1).cost,popc(i,1).output]=costfunction(popc(i,1).position);
      [popc(i,2).cost,popc(i,2).output]=costfunction(popc(i,2).position);
   end
   popc=popc(:);
   % Mutation
   popm=repmat(empty_individual,nm,1);
   for  i=1:nm
      % Select Parent
      i1=randi([1 npop]);
      % Apply Mutation
      popm(i).position=mutation(pop(i1).position,nmu,sigma);
      % Bounded
      popm(i).position=max(popm(i).position,varmin);
      popm(i).position=min(popm(i).position,varmax);
      % Evaluation
      [popm(i).cost,popm(i).output]=costfunction(popm(i).position);
   end
   % Merge
   pop=[pop
       popc
       popm];
   % Sort
   [~,so]=sort([pop.cost]);
   pop=pop(so);
   % Truncate
   pop=pop(1:npop);
   % Find  And  Store And  Display  Best  Solution
   if  pop(1).cost<bestsol.cost
      bestsol=pop(1);
   end
   bestcost(iteration)=bestsol.cost;
   disp(['Iteration:' num2str(iteration) '  Best  Cost:' num2str(bestcost(iteration))]);
   
   
end
%% Display  Result
% Plot  Best  Solution
figure(1);
   plotbestsolution(bestsol.output,problem);
   pause(2);
figure(2);
semilogy(bestcost,'r','LineWidth',2);
xlabel('Iteration');
ylabel('Cost');
title('Community  Detection');
disp(['Cost  Of  Best  Solution:' num2str(bestsol.cost)]);