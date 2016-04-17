require_relative 'node'
require_relative 'edge'
require_relative 'graph'
require_relative 'gtree'

graph = Graph.new("AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7")
puts "hello World"


puts "1)The distance of the route A-B-C"
d1 = graph.calc_route_dist("ABC")
puts "#{d1}"

puts "2)The distance of the route A-D"
d1 = graph.calc_route_dist("AD")
puts "#{d1}"

puts "3)The distance of the route A-D-C"
d1 = graph.calc_route_dist("ADC")
puts "#{d1}"

puts "4)The distance of the route A-E-B-C-D"
d1 = graph.calc_route_dist("AEBCD")
puts "#{d1}"

puts "5)The distance of the route A-E-D"
d1 = graph.calc_route_dist("AED")
puts "#{d1}"

puts "6) The number of trips starting at C and ending at C with a maximum of 3 stops."
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
puts graph.bfs(point1,point2, max_stops,p1,p2).size

puts "7) The number of trips starting at A and ending at C with exactly 4 stops"
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
puts graph.bfs(point1,point2, max_stops,p1,p2).size

puts "8) The length of the shortest route (in terms of distance to travel) from A to C"
point1 = "A"
point2 = "C"
max_dist = 1000
puts graph.bfs_shortest_route(point1,point2, max_dist)[:dist]

puts "9)The length of the shortest route (in terms of distance to travel) from B to B."

point1 = "B"
point2 = "B"
max_dist = 1000
puts graph.bfs_shortest_route(point1,point2, max_dist)[:dist]

puts "10) The number of different routes from C to C with a distance of less than 30."
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
puts graph.bfs(point1,point2, max_dist,p1,p2).size


