require 'four'

RSpec.describe "Game" do
  let(:game) { Game.new }
  let(:board) { game.board }
  let(:player_1) { game.players[0] }
  let(:player_2) { game.players[1] }


  describe "Board" do
    it "has 7 columns" do
      expect(board.grid[0].length).to eq(7)
    end

    it "has 6 rows" do
      expect(board.grid.length).to eq(6)
    end

    it "is mutable" do
      board.drop_disk(3, player_2)
      expect(board.grid[5][2]).to eq(player_2.sign)
    end

    context "when there is a disk in the column" do
      it "leaves the first disk intact" do
        board.drop_disk(3, player_1)
        expect(board.grid[5][2]).to eq(player_2.sign)
      end

      it "adds the disk to the second row" do
        expect(board.grid[4][2]).to eq(player_1.sign)
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
  end

  describe '#game_over?' do
    it "is not over over" do
      expect(game.game_over?).to_not be_truthy
    end

    describe '#victory?' do
      context "when a player has won" do
        it "can win by collecting 4 adjacent disks in one column" do
          board.drop_disk(7, player_1)
          board.drop_disk(7, player_1)
          board.drop_disk(7, player_1)
          board.drop_disk(7, player_1)
          expect(board.victory?(player_1)).to be true
        end

        it "can win by collecting 4 adjacent disks in one row" do
          board.drop_disk(4, player_1)
          board.drop_disk(5, player_1)
          board.drop_disk(6, player_1)
          expect(board.victory?(player_1)).to be true
        end

        it "can win by collecting 4 adjacent disks in diagonal line" do
          board.drop_disk(5, player_1)
          board.drop_disk(6, player_1)
          board.drop_disk(6, player_1)
          board.drop_disk(3, player_2)
          board.drop_disk(4, player_2)
          board.drop_disk(5, player_2)
          board.drop_disk(6, player_2)
          expect(board.victory?(player_2)).to be true
        end
      end

      context "when there are no free cells" do
        it "is a draw" do
          board.drop_disk(1, player_1)
          board.drop_disk(1, player_1)
          board.drop_disk(1, player_1)
          board.drop_disk(1, player_1)
          board.drop_disk(1, player_1)
          board.drop_disk(1, player_1)
          board.drop_disk(2, player_1)
          board.drop_disk(2, player_1)
          board.drop_disk(2, player_1)
          board.drop_disk(2, player_1)
          board.drop_disk(2, player_1)
          board.drop_disk(2, player_1)
          board.drop_disk(3, player_1)
          board.drop_disk(3, player_1)
          board.drop_disk(3, player_1)
          board.drop_disk(4, player_1)
          board.drop_disk(4, player_1)
          board.drop_disk(4, player_1)
          board.drop_disk(4, player_1)
          board.drop_disk(5, player_1)
          board.drop_disk(5, player_1)
          board.drop_disk(5, player_1)
          board.drop_disk(6, player_1)
          board.drop_disk(6, player_1)
          board.drop_disk(7, player_1)
          board.drop_disk(7, player_1)

          expect(board.draw?).to be true
        end
      end
    end
  end
end
