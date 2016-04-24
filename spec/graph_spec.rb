require 'spec_helper'

describe Graph do

  before :each do
    @graph = Graph.new ("AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7")
  end

  describe "#new" do
    it "creates a graph" do
        expect(@graph).to be_an_instance_of Graph
    end

    it "initializes edge to passed parameter" do
     # puts @graph.to_s
    end
    it "no of edges in graph" do
      @graph1 = Graph.new ("AB5, BC4, CD8")
      expect(@graph1.no_of_edges).to eq(3)
    end

    it "creates the following edges" do
      @graph1 = Graph.new ("AB5, BC4, CD8")
      edge1 = @graph1.edges_arr[0]
      edge2 = @graph1.edges_arr[1]
      edge3 = @graph1.edges_arr[2]

      expect(edge1.node_src.node_name).to eq("A")
      expect(edge1.node_dst.node_name).to eq("B")
      expect(edge1.dist).to eq(5)

      expect(edge2.node_src.node_name).to eq("B")
      expect(edge2.node_dst.node_name).to eq("C")
      expect(edge2.dist).to eq(4)

      expect(edge3.node_src.node_name).to eq("C")
      expect(edge3.node_dst.node_name).to eq("D")
      expect(edge3.dist).to eq(8)
    end

    it "creates the following nodes in adjacency list" do
      @graph1 = Graph.new ("AB5, BC4, CD8")
      adj_keys = @graph1.trees.map{|t| t.src_node}
      expect(adj_keys).to eq(["A","B","C"])
    end

    it "creates the following nodes in adjacency list" do
      @graph1 = Graph.new ("AB5, BC4, CD8")
      adj_keys = @graph1.trees.map{|t| t.src_node}
      #adj_list = @graph1.adj_list
    end

    it "distance between A & B" do
      @graph1 = Graph.new ("AB5, BC4, CD8")
      expect(@graph1.distance_between("B","C")).to eq(4)
    end

    it "Route distance of ABC" do
      @graph1 = Graph.new ("AB5, BC4, CD8")
      expect(@graph1.calc_route_dist("ABC")).to eq(9)

      #puts @graph.calc_route_dist("AED")
    end

   end

  it "No of trips starting from point1 to point2 with max n stops" do
    point1 = "C"
    point2 = "C"
    max_stops = 3
    p1 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          (route_arr.size <= (max_stops+1)) && (route_arr.last == point2)
        end
    p2 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          route_arr.size <= (max_stops+1)
        end
    expect(@graph.bfs(point1,point2, max_stops,p1,p2).size).to eq(2)
   end

  it "No of trips starting from point1 to point2 with exactly n stops" do
    point1 = "A"
    point2 = "C"
    max_stops = 4
    p1 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          (route_arr.size == (max_stops+1)) && (route_arr.last == point2)
        end
    p2 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          route_arr.size <= (max_stops+1)
        end
    expect(@graph.bfs(point1,point2, max_stops,p1,p2).size).to eq(3)
   end

  it "The number of different routes from Point1 to Point2 with a distance of less than
max_dist" do
    point1 = "C"
    point2 = "C"
    max_dist = 30
    p1 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          (route_hash[:dist] < max_dist) && (route_arr.last == point2)
         end
    p2 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          route_hash[:dist] < max_dist
         end
    expect(@graph.bfs(point1,point2, max_dist,p1,p2).size).to eq(7)
   end

   it "The length of the shortest route (in terms of distance to travel) from point1 to point2t" do
    point1 = "A"
    point2 = "C"
    max_dist = 1000
    expect(@graph.bfs_shortest_route(point1,point2, max_dist)[:dist]).to eq(9)
   end

   it "The length of the shortest route (in terms of distance to travel) from point1 to point2t" do
    point1 = "B"
    point2 = "B"
    max_dist = 1000
    expect(@graph.bfs_shortest_route(point1,point2, max_dist)[:dist]).to eq(9)
  end

  it "bfs recursive Q6" do
    queue = [{:node => "C", :route => "C"}]
    output = []

    point1 = "C"
    point2 = "C"
    max_stops = 3
    p1 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          (route_arr.size <= (max_stops+1)) && (route_hash[:node] == point2)
        end
    p2 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          route_arr.size <= (max_stops+1)
        end
    p3 = Proc.new do |output, route|
           output<<route
         end
    expect(@graph.bfs_recursive(queue, output,p1,p2,p3).size).to eq(2)
  end

  it "bfs recursive Q7" do
    queue = [{:node => "A", :route => "A"}]
    output = []

    point1 = "A"
    point2 = "C"
    max_stops = 4
    p1 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          (route_arr.size == (max_stops+1)) && (route_hash[:node] == point2)
        end
    p2 = Proc.new do |route_hash|
          route_arr = route_hash[:route]
          route_arr.size <= (max_stops+1)
        end
     p3 = Proc.new do |output, route|
           output<<route
          end

    expect(@graph.bfs_recursive(queue, output,p1,p2,p3).size).to eq(3)
  end

  it "bfs recursive Q8" do
    queue = [{:node => "B", :route => "B"}]
    output = []

    point1 = "B"
    point2 = "B"
    max_dist = 1000
    p1 = Proc.new do |route_hash,dist|
          route_arr = route_hash[:route]
          (dist < max_dist) && (route_hash[:node] == point2)
         end
    p2 = Proc.new do |route_hash,dist|
          route_arr = route_hash[:route]
          dist < max_dist
         end
     p3 = Proc.new do |output, route|
           output<<route
          end
    # puts @graph.bfs_recursive(queue, output,p1,p2,p3).to_s
  end

  it "bfs recursive Q10" do
    queue = [{:node => "C", :route => "C"}]
    output = []

    point1 = "C"
    point2 = "C"
    max_dist = 30
    p1 = Proc.new do |route_hash,dist|
          route_arr = route_hash[:route]
          (dist < max_dist) && (route_hash[:node] == point2)
         end
    p2 = Proc.new do |route_hash,dist|
          route_arr = route_hash[:route]
          dist < max_dist
         end
     p3 = Proc.new do |output, route|
           output<<route
          end
    expect(@graph.bfs_recursive(queue, output,p1,p2,p3).size).to eq(7)
  end



end
