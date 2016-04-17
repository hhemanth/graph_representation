class Gtree
  attr_accessor :src_node, :edges_arr
  def initialize(src_node, edges_arr)
    @src_node = src_node
    @edges_arr = edges_arr
  end

  def no_of_edges
    @edges_arr.size
  end

  def is_src_node?(src)
    @src_node == src
  end
end
