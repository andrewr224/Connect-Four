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
    it "(game) has a board" do
      expect(game.board).to be_truthy
    end

    it "has 7 columns" do
      expect(game.board.field.length).to eq(7)
    end

    it "has 7 rows and a gutter in each column" do
      expect(game.board.field[0].length).to eq(8)
    end

    it "is mutable" do
      game.take_turn(4)
      expect(game.board.field[4][0]).to eq("\u26AA'")
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
      expect(game.board.field[4][0]).to eq("\u26AA'")
      expect(game.board.field[3][0]).to eq("\u26AB'")
    end

    it "can win" do
    end
  end

end
