require 'byebug'

class PolyTreeNode

  attr_accessor :value, :children, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if parent.nil?
      @parent = node
      return if node.nil?
      unless node.children.include?(self)
        node.children << self
      end
    else
      remove_self_from_parent(parent)
      @parent = node
      return if node.nil?
      unless node.children.include?(self)
        node.children << self
      end
    end
  end

  def remove_self_from_parent(node)
    node.children.reject! do |child|
      child == self
    end

  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    raise "node is not a child" unless children.include?(node)
    node.parent = nil
  end

  def dfs(target_value)
    # debugger
    if self.value == target_value
      return self
    end

    children = self.children
    children.each do |child|
      searched = child.dfs(target_value)
      return searched if searched
    end
    nil
  end

  def bfs(target_value)
    queu = [self]

    until queu.empty?
      first = queu.shift
      return first if first.value == target_value
      children = first.children
      queu += children
    end

    nil
  end

end
