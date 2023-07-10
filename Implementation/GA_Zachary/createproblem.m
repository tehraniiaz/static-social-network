function   problem=createproblem()
   % Load  Data
   load('Zachary.mat');
   % Extract  id  From  Graph
   id=Graph.Nodes.id;
   % Extract  Number Of Vertex
   n=numel(id);
   % Extract  Cluster(Community) For  Every Nodes
   cluster=Graph.Nodes.Value;
   % Extract Edge
   edge=Graph.Edges.EndNodes;
   % Extract  Adjacency  Matrix
   A=full(Graph.adjacency);
   % Create List  Of  Nodes
   list=cell(n,1);
   for  i=1:n
      list{i}=union(find(A(i,:)==1),find(A(:,i)==1));
   end
   % Export  Result
   problem.Graph=Graph;
   problem.id=id;
   problem.n=n;
   problem.cluster=cluster;
   problem.edge=edge;
   problem.A=A;
   problem.list=list;
end