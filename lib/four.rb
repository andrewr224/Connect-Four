class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new("\u26AA"), Player.new("\u26AB")]
  end

  def start_game
    puts "The game of Connect Four has begun!"
    take_turn until game_over?
  end


  def take_turn
    @board.show_grid
    current_player = @players.shift

    column = current_player.pick_column
    @board.drop_disk(column, current_player)

    @players << current_player
  end

  def game_over?
    if @board.victory?(players.last)
      @board.show_grid
      puts ["The #{players.last.sign} player is victorious!",
        "The #{players.last.sign} player shall drink from the cup of a champion today!",
        "The #{players.last.sign} player has crushed the enemy!",
        "The #{players.last.sign} player is unstoppable!",
        "The #{players.last.sign} player is reigns supreme!"
      ].sample
      return true
    elsif @board.draw?
      @board.show_grid
      puts "It's a draw!"
      return true
    end
  end

  class Board
    attr_reader :grid
    @@grid = [["_","_","_","_","_","_","_"],["_","_","_","_","_","_","_"],
              ["_","_","_","_","_","_","_"],["_","_","_","_","_","_","_"],
              ["_","_","_","_","_","_","_"],["_","_","_","_","_","_","_"]
            ]

    def initialize
      @grid = @@grid.dup
    end

    def drop_disk(col, player)
      col -= 1
      i = 5
      until (@grid[i][col] == "_") || i < 0
        i -= 1
      end

      if i >= 0
        @grid[i][col] = "#{player.sign}"
      else
        puts "The coulumn is already full."
        drop_disk(player.pick_column, player)
      end
    end

    def show_grid
      puts
      grid.each do |row|
        print "|"
        row.each do |e|
          print "#{e}|"
        end
        puts
      end
      puts " 1 2 3 4 5 6 7"
    end

    def victory?(player)
      @grid.each_with_index do |row, i|
        row.each_with_index do |cell, ii|
          if cell == player.sign

            #Vertical check
            score = 0
            j = i
            until (j < 0) || @grid[j][ii] != cell
              score += 1
              j -= 1
            end
            return true if score == 4

            #Horizontal check
            score = 0
            j = ii
            until (j < 0) || @grid[i][j] != cell
              score += 1
              j -= 1
            end
            return true if score == 4

            #Diagonal check
            score = 0
            j = i
            jj = ii
            until (j < 0 && jj < 0) || @grid[j][jj] != cell
              score += 1
              j -= 1
              jj -= 1
            end
            return true if score == 4

            #Diagonal check (different axis)
            score = 0
            j = i
            jj = ii
            until (i < 0 && jj > 6) || @grid[j][jj] != cell
              score += 1
              j -= 1
              jj += 1
            end
            return true if score == 4

          end
        end
      end
      false
    end

    def draw?
      return true unless @grid.flatten.include? "_"
      false
    end
  end

  class Player
    attr_reader :sign
    def initialize(sign)
      @sign = sign
    end

    def pick_column
      print "Please pick a culumn to drop your disk: "
      answer = answer || gets.chomp.to_i
      until (1..7).include? answer
        print "\nEnter a number between 1 and 7: "
        answer = gets.chomp.to_i
      end
      answer
    end
  end
end


