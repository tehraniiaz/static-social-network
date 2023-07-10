function    [y1,y2]=crossover(x1,x2)
   s=randi([1 3]);
   switch  s
       case 1
           [y1,y2]=singlepointcrossover(x1,x2);
       case 2
           [y1,y2]=doublepointcrossover(x1,x2);
       case 3
           [y1,y2]=uniformcrossover(x1,x2);
   end
end
function  [y1,y2]=singlepointcrossover(x1,x2)
   nvar=numel(x1);
   cp=randi([1 nvar-1]);
   y1=[x1(1:cp) x2(cp+1:end)];
   y2=[x2(1:cp) x1(cp+1:end)];
end
function  [y1,y2]=doublepointcrossover(x1,x2)
   nvar=numel(x1);
   cp=randsample(nvar,2)';
   cp1=min(cp);
   cp2=max(cp);
   y1=[x1(1:cp1) x2(cp1+1:cp2) x1(cp2+1:end)];
   y2=[x2(1:cp1) x1(cp1+1:cp2) x2(cp2+1:end)];
end
function   [y1,y2]=uniformcrossover(x1,x2)
  nvar=numel(x1);
  gamma=0.1;
  alpha=unifrnd(-gamma,1+gamma,1,nvar);
  y1=alpha.*x1+(1-alpha).*x2;
  y2=alpha.*x2+(1-alpha).*x1;
end