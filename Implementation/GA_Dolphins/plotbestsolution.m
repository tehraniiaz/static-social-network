function  plotbestsolution(output,problem)
   % Import  Data
   Graph=problem.Graph;
   cluster=problem.cluster;
   clusternew=output.clusternew;
   accuracy=output.accuracy;
   % Plot
   subplot(1,2,1);
   plot(Graph,'NodeCData',cluster,'MarkerSize',16);
   title(['Main Graph:' num2str(max(cluster)) 'Community']);
   subplot(1,2,2);
   plot(Graph,'NodeCData',clusternew,'MarkerSize',16);
   title(['New Graph:' num2str(max(clusternew)) ' Community  Accuracy:%' num2str(accuracy)]);
end