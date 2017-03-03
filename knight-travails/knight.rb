require 'byebug'
require_relative '../binary-tree-search/lib/00_tree_node.rb'

class KnightPathFinder

  attr_reader :starting_pos, :visited_positions

  def initialize(pos)
    @starting_pos = pos
    @visited_positions = [starting_pos]
    @move_tree = build_move_tree
  end

  def self.valid_moves(pos)

    all_moves = []

    row = pos[0]
    col = pos[1]

    #move up
      #up left
      new_row = row - 2
      new_col = col - 1
      all_moves << [new_row, new_col]
      #up right
      new_row = row + 2
      new_col = col + 1
      all_moves << [new_row, new_col]
    #move down
      #down left
      new_row = row + 2
      new_col = col - 1
      all_moves << [new_row, new_col]
      #down right
      new_row = row + 2
      new_col = col + 1
      all_moves << [new_row, new_col]

    #move left
      #left up
      new_row = row - 1
      new_col = col - 2
      all_moves << [new_row, new_col]
      #left down
      new_row = row + 1
      new_col = col - 2
      all_moves << [new_row, new_col]

    #move right
    #right up
    new_row = row - 1
    new_col = col + 2
    all_moves << [new_row, new_col]
    #right down
    new_row = row + 1
    new_col = col + 2
    all_moves << [new_row, new_col]

    all_moves.reject! do |pos|
      row = pos[0]
      col = pos[1]
      row > 7 || row < 0 || col > 7 || col < 0
    end

    all_moves.uniq
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    return nil if moves.nil?
    result = []
    moves.each do |move|
      if !visited_positions.include?(move)
        result << move
        visited_positions << move
      end
    end
    result
  end

  def build_move_tree
    collection = [starting_pos]
    # debugger
    until collection.empty?
      starting_move = PolyTreeNode.new(collection.shift)
      possible_moves = new_move_positions(starting_move.value)
      collection += possible_moves
      possible_moves.each do |move|
        child = PolyTreeNode.new(move)
        starting_move.add_child(child)
      end
    end

  end

end

move = KnightPathFinder.new([0, 0])
print move.visited_positions
