require 'colorize'
class Knight
  include Enumerable
  
  def initialize(x, y)
    @board = Array.new(8) {Array.new(8, "X")}
    @position_x = x
    @position_y = y
    @current_position = [x,y]
    @text_content = "K".red.bold
    @board[@position_x][@position_y] = @text_content
    @legal_moves = []

  end

  def possible_moves(x=@position_x, y=@position_y)
    @legal_moves = []
    @possible_moves = [
      [x - 2, y + 1],
      [x - 1, y + 2],

      [x + 1, y + 2],
      [x + 2, y + 1],

      [x + 2, y - 1],
      [x + 1, y - 2],

      [x - 2, y - 1],
      [x - 1, y - 2]
      ]
    #shovels all possible legal moves into legal moves instance variable
    #--------------------puts "Possible moves from #{x}, #{y}"
    @possible_moves.each do |x|
      if (x[0] < 8) && (x[1] < 8) && (x[0] >= 0) && (x[1] >= 0)
        #p x 
        @legal_moves << x
      end
    end
    @legal_moves
  end

  def show_legal_moves
    possible_moves
    @legal_moves.each do |i|
      @board[i[0]][i[1]] = "K".red.bold
    end
    print_board
    reset_board
    @board[@position_x][@position_y] = @text_content
  end

  def reset_board
    @board = Array.new(8) {Array.new(8, "X")}
  end

  def print_board
    8.times do |i|
      8.times do |j|
      if i % 2 == 0 && j % 2 == 0
        @board[i][j] = @board[i][j].colorize(:background => :blue)
      elsif i % 2 != 0 && j % 2 != 0
        @board[i][j] = @board[i][j].colorize(:background => :blue)
      end
    end
    end

    8.times do |i|
      puts "#{i} #{@board[i].join(" ")}"
    end
    p " 0 1 2 3 4 5 6 7"
  end

  def move(x, y)
    reset_board
    @position_x = x
    @position_y = y
    @board[@position_x][@position_y] = @text_content
    @current_position = [@position_x, @position_y]

  end

#my first attempt
  # def knight_moves2(destination, current_position=[@current_position], counter=0)
  #   counter = 0
  #   queue = []
  #   queue.push(current_position.join.to_s)
  #   while !queue.empty?
  #     temp_position = [queue[0].slice!(0,1).to_i, queue[0].slice!(0,1).to_i]
  #     p temp_position
  #     if temp_position == destination
  #       puts "You made it in #{counter} moves!"
  #       return p "#{temp_position} equals #{destination}"
  #     end
  #     p "Iterating..."
  #     queue.push(possible_moves(temp_position[0], temp_position[1]).join.to_s)
  #     queue = Array.new(1, queue.join)
  #     counter += 1
  #     p "queue is #{queue.join}"
      
  #   end
  # end

  def knight_moves(destination, current_position=@current_position)
    counter = 0
    current_node = Move_node.new(current_position)
    queue = [current_node]
    while !queue.empty?
      current_node = queue.shift

      if current_node.value == destination
        path = current_node.reverse_search << [current_node.value[0], current_node.value[1]]
        puts "You made it in #{path.size - 1} moves!"
        path.each {|i| p i}
        return
      end
      #return current_node.reverse_search if current_node.value == destination
      current_node.generate_children
      current_node.children.each {|i| queue << i if i}
       
      #queue.push(current_node.generate_children) 
      #possible_moves(current_node.value[0], current_node.value[1]).each {|i| i = Move_node.new(i)}
      counter += 1
    end
  end
end

class Move_node < Knight
  attr_accessor :children, :value, :parent

  def initialize(value, parent=nil, children=nil)
    @value = value #position
    @children = children #array of positions
    @parent = parent
  end

  def generate_children(node=self)
    return puts "Node has children" if node.children != nil
    tmp = possible_moves(node.value[0], node.value[1])
    tmp.map! {|i| i = Move_node.new(i, node)}
    node.children = tmp
    node.children
  end

  def reverse_search(node=self, path=[])
    path << node.parent.value if node.parent
    return path.reverse! if !node.parent
    reverse_search(node.parent, path)
  end
end
 
 

knight = Knight.new(0,0)
knight.show_legal_moves
knight.move(4,3)
knight.show_legal_moves
knight.knight_moves([7,7])

