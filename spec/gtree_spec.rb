require 'spec_helper'

describe Gtree do

  before :each do
    @graph = Graph.new ("AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7")
    @trees = []
    grouped_edges = @graph.edges_arr.group_by{|e| e.node_src_name}
    src_node = "A"
    @gtree = Gtree.new(src_node , grouped_edges[src_node])


  end

  describe "#new" do
    it "creates a graph" do
        expect(@gtree).to be_an_instance_of Gtree
    end

    it "no ef edges" do
        expect(@gtree.no_of_edges).to  eq(3)
    end

     it "is src node" do
        expect(@gtree.is_src_node?("A")).to  eq(true)
        expect(@gtree.is_src_node?("B")).to  eq(false)
    end

  end

end

