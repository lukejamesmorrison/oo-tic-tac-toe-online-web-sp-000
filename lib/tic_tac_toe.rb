class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row

    [0,3,6],  # Left column
    [1,4,7],  # Middle column
    [2,5,8],  # Right column

    [0,4,8],  # Top-Left cross
    [6,4,2]  # Bottom-Left cross
  ]

  ##
  # Initalize the object.
  ##
  def initialize(board = nil)
    @board = board || Array.new(9, ' ')
  end

  ##
  # Display the board.
  ##
  def display_board()
    board = @board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  ##
  # Convert user input to board index.
  #
  # The input must me a string representation of an integer between 1 and 9.
  ##
  def input_to_index(input)
    index = input.to_i - 1
    @index = index.between?(0,8) ? index : -1
  end

  ##
  # Conduct a single move on the board at '@index' with 'character'.
  ##
  def move
    if @board[@index] === " "
      @board[@index] = @player
      display_board
    end
  end

  ##
  # Get the current player.
  ##
  def current_player()
    t_count = turn_count
    t_count == 0 || t_count % 2 == 0 ? "X" : "O"
  end

  ##
  # Get the number of turns conducted so far.
  ##
  def turn_count
    @board.reject{|cell| cell == ' '}.length
  end

  ##
  # Is move at 'index' valid?
  ##
  def valid_move?
    if @index == nil || @index > @board.length - 1 || @index < 0
      return false
    end
    !position_taken?
  end

  ##
  # Is position at 'index' taken?
  ##
  def position_taken?
    !(@board[@index].nil? || @board[@index] == " ")
  end

  ##
  # Is the game a draw? (no winners)
  ##
  def draw?
    full? && !won?
  end

  ##
  # Is the board currently empty?
  ##
  def empty?
    @board.select{|cell| cell == ' '}.length == 9
  end

  ##
  # Is the board currently full?
  ##
  def full?
    @board.select{|cell| cell == 'X' || cell == "O"}.length == 9
  end

  ##
  # Is the game over?
  ##
  def over?
    won? || draw?
  end

  ##
  # Get the winner of the game if the game has been won.
  ##
  def winner
    won? ? board[won?[0]] : nil
  end

  ##
  # Has the game been won?
  ##
  def won?
    # The winning combo
    winning_combo = nil

    # Detect if board is empty
    if empty?
      return false
    end

    # Detect if game has been won
    WIN_COMBINATIONS.each do |combo|
      cell_1 = combo[0]; cell_2 = combo[1]; cell_3 = combo[2]

      # If first position is empty, move to next combo immediately
      if !position_taken?
        next
      end

      # If the cells match
      cells_match = @board[cell_1] == @board[cell_2] && @board[cell_1] == @board[cell_3]
      # If first cell is X or O
      first_is_valid = @board[cell_1] == "X" || @board[cell_1] == "O"

      if first_is_valid && cells_match
        winning_combo = combo
        break
      end
    end

    return winning_combo != nil ? winning_combo : false
  end

  ##
  # Conduct a single turn.
  ##
  def turn
    puts "Please enter 1-9:"
    input_to_index(gets.strip)
    @player = current_player
    valid_move? ? move : turn
  end

  ##
  # Play game.
  ##
  def play(board)
    until over? do
      turn
    end

    puts won? ? "Congratulations #{winner}!" : "Cat's Game!"
  end
end
