require 'four'

RSpec.describe "Game" do
  let(:game) { Game.new }

  describe '#game_over?' do
    it "is not over over" do
      expect(game.game_over?).to be false
    end

    context "when a player has won" do
      it "is over" do

      #  expect(game.game_over?).to be true
      end
    end

    context "when it's a draw" do
    end
  end

  describe "Board" do
    let(:board) { game.board }

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
      game.take_turn(4)
      expect(board.grid[5][3]).to eq("\u26AA")
    end

    context "when there is a disk in the column" do
      it "leaves the first disk intact" do
        game.take_turn(2)
        game.take_turn(2)
        expect(board.grid[5][1]).to eq("\u26AA")
      end

      it "adds the disk to the second row" do
        expect(board.grid[4][1]).to eq("\u26Ab")
      end

    end

    context "when the column if full" do
      it "prompts user to pick another column" do

      end
    end
  end

  describe "Players" do
    it "(game) has two players" do
      expect(game.players.length).to eq(2)
    end

    it "has it's unique sign" do
      expect(game.players[0].sign).to_not eq(game.players[1].sign)
    end

    it "can change the cell on the board" do
      game.take_turn(4)
      game.take_turn(3)
      expect(game.board.grid[5][3]).to eq("\u26AA")
      expect(game.board.grid[5][2]).to eq("\u26AB")
    end

    it "can win" do
      game.take_turn(4)
      game.take_turn(5)
      game.take_turn(4)
      expect(game.game_over?).to be true
    end
  end

end
