module DOMParser

class TreeSearcher

  def initialize(tree)
    @tree = tree
    @current_node = tree
  end

  def search_by(attribute, value)
    @current_node = @tree
    results = []
    stack = []
    results << @current_node if @current_node.matches_attribute?(attribute, value)
    @current_node.children.each do |child|
      if child.is_a?(Node)
        stack << child
      end
    end
    until stack.empty?
      @current_node = stack.pop
      results << @current_node if @current_node.matches_attribute?(attribute, value)
      @current_node.children.each do |child|
        if child.is_a?(Node)
          stack << child
        end
      end
    end
  results
  end

  def search_descendents(node, attribute, value)
    results = []
    stack = []
    results << node if node.matches_attribute?(attribute, value)
    node.children.each do |child|
      if child.is_a?(Node)
        stack << child
      end
    end
    until stack.empty?
      current_node = stack.pop
      results << current_node if current_node.matches_attribute?(attribute, value)
      current_node.children.each do |child|
        if child.is_a?(Node)
          stack << child
        end
      end
    end
    retresults
  end

  def search_ancestors(node, attribute, value)
    results = []
    stack = []
    results << node if node.matches_attribute?(attribute, value)
    node.children.each do |child|
      if child.is_a?(Node)
        stack << child
      end
    end
    until stack.empty?
      current_node = stack.pop
      results << current_node if current_node.matches_attribute?(attribute, value)
    end
    results
  end

end

end