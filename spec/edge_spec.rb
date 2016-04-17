require 'spec_helper'

describe Edge do

  before :each do
    @edge = Edge.new "AB5"
  end

  describe "#new" do
    it "creates a new Edge" do
        expect(@edge).to be_an_instance_of Edge
    end

    it "initializes edge to passed parameter" do
      puts @edge.to_s
      expect(@edge.node_src.node_name).to eq("A")
      expect(@edge.node_dst.node_name).to eq("B")
      expect(@edge.dist).to eq(5)
    end

    it "returns true if a particular node name is src" do
      @edge1 = Edge.new("CD9")
      expect(@edge1.is_src?("C")).to eq(true)
    end

    it "returns true if a particular node name is src" do
      @edge2 = Edge.new("CD9")
      expect(@edge2.is_dst?("D")).to eq(true)
    end


end

end
