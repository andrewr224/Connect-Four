class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new, Player.new]
  end

  def show_board
    @board.to_s
  end

  def game_over?
    false
  end

  def pick_cell(col)
    @board.drop_disk(col)
  end

  class Board
    attr_reader :field
    @@field = [["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"],["'"," '"," '"," '"," '"," '"," '"," '"]]

    def initialize
      @field = @@field.dup
    end

    def drop_disk(col)
      @field[col][0] = "+'"
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
  end
end
