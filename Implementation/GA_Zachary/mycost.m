function    [z,output]=mycost(x,problem)
   % Import  Data
   id=problem.id;
   n=problem.n;
   cluster=problem.cluster;
   list=problem.list;
   A=problem.A;
   % Create  Genome
   genome=zeros(1,n);
   for  i=1:n
      B=numel(list{i});
      y=min(floor(B*x(i)+1),B);
      genome(i)=list{i}(y);
   end
   % Create  New Graph
   newGraph=graph(id,genome);
   % Determined Clutser(Community)  id  For Every Node
   clusternew=conncomp(newGraph);
   % Determined  Numnber Of  Cluster(Community)  Detection
   nclusternew=max(clusternew);
   % Calculate  Cost  Value 
   C=nclusternew;
   z=0;
   interconnection=zeros(1,C);
   intraconnection=zeros(1,C);
   if  C>=2
       for  c=1:C
          intraconnection(c)=0;
          vi=find(clusternew==c);
          for  i=vi
             for  j=vi
                 intraconnection(c)=intraconnection(c)+A(i,j);
             end
          end
          interconnection(c)=0;
          vj=find(clusternew~=c);
          for  i=vi
             for  j=vj
                interconnection(c)=interconnection(c)+A(i,j); 
             end
          end
          z=z+interconnection(c)/intraconnection(c);
       end
   else
       z=1e7;
   end
   % Export  Result
   i=find(clusternew==1);
   j=find(clusternew==2);
   clusternew(i)=2;
   clusternew(j)=1;
   TP=numel(find(cluster==clusternew'));
   FN=n-TP;
   accuracy=TP/(TP+FN)*100;
   output.TP=TP;
   output.FN=FN;
   output.accuracy=accuracy;
   output.genome=genome;
   output.newGraph=newGraph;
   output.clusternew=clusternew;
   output.nclusternew=nclusternew;
   output.intraconnect=intraconnection;
   output.interconnection=interconnection;
   output.z=z;
   
end