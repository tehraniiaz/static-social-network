function   i=tournamentselection(pop,ts)
   npop=numel(pop);
   s=randsample(npop,ts)';
   costs=[pop(s).cost];
   [~,mi]=min(costs);
   i=s(mi);
end