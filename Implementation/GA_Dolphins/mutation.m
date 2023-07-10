function   y=mutation(x,nmu,sigma)
   nvar=numel(x);
   i=randsample(nvar,nmu)';
   y=x;
   y(i)=x(i)+sigma*randn(1,nmu);
end