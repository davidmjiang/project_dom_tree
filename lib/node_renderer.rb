require_relative 'html_parser'
require_relative 'tree_searcher'

class NodeRenderer

  def initialize(tree)
    @tree = tree
    @current_node = nil
    @tags = Hash.new(0)
  end

  def render_results(results)
   puts "We found #{results.length} results for your search."
   results.each {|result| puts result}
  end

  def render_stats(node=nil)
    if node
      @current_node = node
      node_to_check = node
    else
      @current_node = @tree
      node_to_check = @tree
    end
    puts "There are #{count_nodes} nodes in the sub-tree below this node."
    @tags.each do |tag, number|
      puts "<#{tag}>: #{number}"
    end 
    puts "Here are the attributes for your starting node:"
    node_to_check.attributes.each do |attribute, value|
      puts "#{attribute} = #{value}"
    end
  end

  def count_nodes
    total_nodes = 0
    stack = []
    @current_node.children.each do |child|
      if child.is_a?(Node)
        stack << child
        @tags[child.attributes[:type]] += 1
        total_nodes += 1
      end
    end
    until stack.empty?
      @current_node = stack.pop
      @current_node.children.each do |child|
        if child.is_a?(Node)
          stack << child
          @tags[child.attributes[:type]] += 1
          total_nodes += 1
        end
      end
    end
    total_nodes
  end

end


test_file = File.read("test.html")
parser = HTMLParser.new(test_file)
parser.parse
searcher = TreeSearcher.new(parser.root)
renderer = NodeRenderer.new(parser.root)
lists = searcher.search_by(:type, "li")
renderer.render_results(lists)


