class Node
  attr_accessor :node_name, :valid

  def initialize(str)
    @valid = false
    @node_name = str.upcase
    #@valid = validate
  end

  def to_s
    "#{@node_name}"
    #{}"invalid node : Node Name has to be alphabet, currently it is #{@node_name}"
  end

  def is_valid?
    @valid
  end

  def validate
     @node_name[/[A-Z]+/]  == @node_name
  end
end
