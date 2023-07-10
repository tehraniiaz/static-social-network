function  plotbestsolution(output,problem)
   % Import  Data
   Graph=problem.Graph;
   cluster=problem.cluster;
   clusternew=output.clusternew;
   i=find(clusternew==1);
   j=find(clusternew==2);
   clusternew(i)=2;
   clusternew(j)=1;
   accuracy=output.accuracy;
   % Plot
   subplot(1,2,1);
   plot(Graph,'NodeCData',cluster,'MarkerSize',16);
   title(['Main Graph:' num2str(max(cluster)) 'Community']);
   subplot(1,2,2);
   plot(Graph,'NodeCData',clusternew,'MarkerSize',16);
   title(['New Graph:' num2str(max(clusternew)) ' Community  Accuracy:%' num2str(accuracy)]);
end