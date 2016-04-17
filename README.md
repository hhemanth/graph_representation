I have used Ruby 2.2  & rspec (3.4.0) to code this application.

How to run the code?
Go to directory
cd jiffle_now_task

ruby main.rb

Running tests
inside the directory jiffle_now_task
rspec spec/

I have the following classes
*Node
*Edge
*Graph
*Gtree

Node has a nodename (which is a single Alphabet)
Edge has 2 Nodes and one field dist which stores distance.
Gtree has a src_node and list of edges (basically representation of adjacency list)
Graph is a array of Gtrees

The main.rb initializes the Graph object and answers questions using the following 3 methods

-calc_route_dist (To find the distance of a given route like "ABC" or BCD" if route exists)
-bfs - does a bfs traversal of the graph and answers questions about routes. I am particularly proud of this piece of code as I have effectively used proc to make this method answer different set of question. Without Proc it wouldnt have been possible
-bfs_shortest_route - an extension of the previous method. If I had more time, I would have merged  the above method this this and used another proc. But left it at that.

The code is pretty generic. Will wok on any graphs and any representation.
For example right now, the edge representation is AB6, but it could easily by AB#BC#34 or anyhing like that.