require 'four'

RSpec.describe "Game" do
  let(:game) { Game.new }
  let(:board) { game.board }
  let(:player_1) { game.players[0] }
  let(:player_2) { game.players[1] }

  describe '#game_over?' do
    it "is not over over" do
      expect(game.game_over?).to be false
    end

    # it may show victory because of the condtions met in the previous test
    # need to separate them somehow
    describe '#victory?' do
      context "when a player has won" do
        it "can win by collecting 4 adjacent disks in one column" do
          board.drop_disk(5, player_1)
          board.drop_disk(5, player_1)
          board.drop_disk(5, player_1)
          board.drop_disk(5, player_1)
          expect(board.victory?(player_1)).to be true
        end

        it "can win by collecting 4 adjacent disks in one row" do
          board.drop_disk(4, player_1)
          board.drop_disk(5, player_1)
          board.drop_disk(6, player_1)
          board.drop_disk(7, player_1)
          expect(board.victory?(player_1)).to be true
        end
      end

      context "when it's a draw" do
      end
    end
  end

  describe "Board" do
    it "(game) has a board" do
      expect(board).to be_truthy
    end

    it "has 7 columns" do
      expect(board.grid[0].length).to eq(7)
    end

    it "has 6 rows" do
      expect(board.grid.length).to eq(6)
    end

    it "is mutable" do
      board.drop_disk(4, player_1)
      expect(board.grid[5][3]).to eq(player_1.sign)
    end

    context "when there is a disk in the column" do
      it "leaves the first disk intact" do
        board.drop_disk(2, player_1)
        board.drop_disk(2, player_2)
        expect(board.grid[5][1]).to eq(player_1.sign)
      end

      it "adds the disk to the second row" do
        expect(board.grid[4][1]).to eq(player_2.sign)
      end

    end

    context "when the column if full" do
      it "doesn't change the column" do

      end
    end
  end

  describe "Players" do
    it "(game) has two players" do
      expect(game.players.length).to eq(2)
    end

    it "has it's unique sign" do
      expect(player_1.sign).to_not eq(player_2.sign)
    end

    it "can change the cell on the board" do
      board.drop_disk(4, player_1)
      board.drop_disk(3, player_2)
      expect(game.board.grid[5][3]).to eq(player_1.sign)
      expect(game.board.grid[5][2]).to eq(player_2.sign)


    end
  end

end
