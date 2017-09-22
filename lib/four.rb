class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new("\u26AA"), Player.new("\u26AB")]
    # take_turn until game_over?
  end

  def take_turn(pick=nil)
    current_player = @players.shift

    column = current_player.pick_column(pick)
    @board.drop_disk(column, current_player.sign)

    @players << current_player
  end

  def show_board
    @board.to_s
  end

  def game_over?
    @players[0].sign == "\u26AB" ? true : false
  end

  class Board
    attr_reader :field
    @@field = [["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"]]

    def initialize
      @field = @@field.dup
    end

    def drop_disk(col, sign)
      @field[col][0] = "#{sign}'"
    end

    def to_s
      field.each do |row|
        row.each do |e|
          print e
        end
        puts
      end
      puts " 1 2 3 4 5 6 7"
    end

  end

  class Player
    attr_reader :sign
    def initialize(sign)
      @sign = sign
    end

    def pick_column(answer=nil)
      #print "Please enter a culumn number to drop your disk: "
      answer = answer || gets.chomp.to_i
      until (1..7).include? answer
        print "\nEnter a number between 1 and 7: "
        answer = gets.chomp
      end
      answer
    end
  end
end
