require 'spec_helper'

describe Node do

  before :each do
    @node = Node.new "A"
  end

  describe "#new" do
    it "creates a new Node" do
        expect(@node).to be_an_instance_of Node
    end

    it "initializes node_name to passed parameter" do
      #puts @node.to_s
      expect(@node.node_name).to  eq("A")
    end

    it "validate Node" do
      #puts @node.to_s
      @node1 = Node.new("8")
      expect(@node1.is_valid?).to  eq(false)
      puts @node1.to_s
    end
end

end
