
class Graph
  attr_accessor :edges_arr, :trees

  def initialize(str)
    @edges_arr = []
    edges_str_arr = str.split(",").map(&:strip)
    edges_str_arr.each { |edge_str| @edges_arr << Edge.new(edge_str) }
    # build_adj_list
    @trees= []
    build_trees
  end

  def to_s
     puts "Edges_list"
     puts "---------------"

     @edges_arr.each {|e| puts e.to_s}

     puts ""
     puts "Adjacency List"
     puts "---------------"

    @trees.each do |tree|
      #print "\n"
      #print "*#{src_node} ->"

      edges =  tree.edges_arr
      edges.each{|e| print "#{e.to_s} | "}
    end
     puts ""
  end

  # def build_adj_list
  #   @adj_list = {}
  #   @edges_arr.each do |edge|
  #     if @adj_list[edge.node_src.node_name].nil?
  #       @adj_list[edge.node_src.node_name] = []
  #     end
  #     @adj_list[edge.node_src.node_name] << edge
  #   end
  # end

  def build_trees
    grouped_edges = @edges_arr.group_by{|e| e.node_src_name}
    grouped_edges.keys.each do |src_node|
      gt = Gtree.new(src_node , grouped_edges[src_node])
      @trees << gt
    end
  end

  def no_of_edges
    @edges_arr.size
  end

  def distance_between(src,dst)
    e1 = edges_arr.select{|e| (e.is_src?(src) && e.is_dst?(dst))}
    return -1 if e1.nil? || e1.empty?
    return e1.first.dist
  end

  def calc_route_dist(str)
    route_arr = str.split("")
    route_dist = 0
    for i in 0..route_arr.size-2 do
      dist = distance_between(route_arr[i], route_arr[i+1])
      return -1 if dist == -1
      route_dist += dist
    end

    return route_dist
  end

  def trips_from_P1_to_P2_max_N_stops(point1,point2,max_stops)
    p1 = Proc.new do |route_hash|
      route_arr = route_hash[:route]
      (route_arr.size <= (max_stops+1)) && (route_arr.last == point2)
    end
    p2 = Proc.new do |route_hash|
      route_arr = route_hash[:route]
      route_arr.size <= (max_stops+1)
    end
    return bfs(point1,point2, max_stops,p1,p2)
  end

  def trips_from_P1_to_P2_exact_N_stops(point1,point2,max_stops)
    p1 = Proc.new do |route_hash|
      route_arr = route_hash[:route]
      (route_arr.size == (max_stops+1)) && (route_arr.last == point2)
    end
    p2 = Proc.new do |route_hash|
      route_arr = route_hash[:route]
      route_arr.size <= (max_stops+1)
    end
    return bfs(point1,point2, max_stops,p1,p2)
  end

  def trips_from_P1_to_P2_max_distance(point1,point2,max_dist)
    p1 = Proc.new do |route_hash|
      route_arr = route_hash[:route]
      (route_hash[:dist] < max_dist) && (route_arr.last == point2)
     end
    p2 = Proc.new do |route_hash|
      route_arr = route_hash[:route]
      route_hash[:dist] < max_dist
     end
    return bfs(point1,point2, max_dist,p1,p2)
  end

  def bfs_shortest_route(start_node,end_node, max_dist)
    node_and_route = init_node_and_route(start_node)
    queue = [node_and_route]
    routes = [[start_node]]
    cur_route = routes.first
    all_routes = []
    shortest_route = nil
    shortest_dist = max_dist

    while(!queue.empty? )
      cur_nr = queue.shift()
      tree = @trees.select{|t| t.is_src_node?(cur_nr[:node])}.first
      r = cur_nr[:route]

      tree.edges_arr.each do |edge_child|
           nr = get_next_nr(edge_child,cur_nr,r)
           if (nr[:route].last == end_node)
            all_routes << nr[:route]
            shortest_route = nr if nr[:dist] < shortest_dist
            shortest_dist = nr[:dist]
           end
           queue.push(nr) if (nr[:dist] < shortest_dist)
      end

    end

    return shortest_route
  end

  def bfs(start_node,end_node,max_stops,proc1,proc2)
    node_and_route = init_node_and_route(start_node)
    queue = [node_and_route]
    routes = [[start_node]]
    cur_route = routes.first
    all_routes = []

    while(!queue.empty?)
      cur_nr = queue.shift()
      tree = @trees.select{|t| t.is_src_node?(cur_nr[:node])}.first
      r = cur_nr[:route]

      tree.edges_arr.each do |edge_child|
         child = edge_child.node_dst_name
         nr = get_next_nr(edge_child,cur_nr,r)
         all_routes << nr[:route] if ( proc1.call(nr))
         queue.push(nr) if ( proc2.call(nr))
      end

    end

    return all_routes
  end



  private
  def init_node_and_route(start_node)
    node_and_route = {}
    node_and_route[:node] = start_node
    node_and_route[:route] = [start_node]
    node_and_route[:dist] = 0
    return node_and_route
  end

  def get_next_nr(edge, cur_nr,route)
    child = edge.node_dst_name
    nr = {}
    nr[:node] = child
    r1 = Array.new(route)
    nr[:route] = r1.push(child)
    nr[:dist] = cur_nr[:dist] + edge.dist
    return nr
  end




end

