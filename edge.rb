class Edge
  attr_accessor :node_src, :node_dst, :dist, :valid, :errors

  def initialize(str)
    @valid = false
    node_arr = str.split("")
    @node_src = Node.new(node_arr[0])
    @node_dst = Node.new(node_arr[1])
    @dist = node_arr[2].to_i
    @valid = validate
  end

  def node_src_name
    @node_src.node_name
  end

  def node_dst_name
    @node_dst.node_name
  end

  def to_s
    "#{@node_src.to_s} -> #{@node_dst.to_s}(#{@dist})"
  end

  def is_src?(str)
    @node_src.node_name == str ? true : false
  end

  def is_dst?(str)
    @node_dst.node_name == str ? true : false
  end

  def is_valid?
    @valid
  end

  def validate
    true
  end

end
