class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new("\u26AA"), Player.new("\u26AB")]

    puts "The game of Connect Four has begun!"
    #take_turn until game_over?
  end

  def take_turn(pick=nil)
    puts
    show_board
    current_player = @players.shift

    column = current_player.pick_column(pick)
    @board.drop_disk(column, current_player.sign)

    @players << current_player
  end

  def show_board
    @board.show_grid
  end

  def game_over?
    false unless @players.last.victory? || @board.draw?
  end

  class Board
    attr_reader :grid
    @@grid = [["_","_","_","_","_","_","_"],["_","_","_","_","_","_","_"],["_","_","_","_","_","_","_"],["_","_","_","_","_","_","_"],["_","_","_","_","_","_","_"],["_","_","_","_","_","_","_"]]

    def initialize
      @grid = @@grid.dup
    end

    def drop_disk(col, sign)
      col -= 1
      i = 5
      until (@grid[i][col] == "_") || i < 0
        i -= 1
      end
      @grid[i][col] = "#{sign}"

      puts
      show_grid
    end

    def show_grid
      grid.each do |row|
        print "|"
        row.each do |e|
          print "#{e}|"
        end
        puts
      end
      puts " 1 2 3 4 5 6 7"
    end

    def draw?
      false
    end
  end

  class Player
    attr_reader :sign
    def initialize(sign)
      @sign = sign
    end

    def pick_column(answer=nil)
      print "Please enter a culumn to drop your disk in: "
      answer = answer || gets.chomp.to_i
      until (1..7).include? answer
        print "\nEnter a number between 1 and 7: "
        answer = gets.chomp.to_i
      end
      answer
    end

    def victory?
      false
    end
  end
end

Game.new
