require 'spec_helper'

describe Game do
  describe 'Attributes' do
  end

  describe 'Factories' do
    it 'create a game' do
      g = create :game
      g.id.should_not be_nil
    end
  end
  
  describe 'Methods' do
    let(:g)   { Game.new maximum_number_of_players: 4}

    describe 'Class Methods' do
    end

    describe 'Instance Methods' do
      describe '#initialize' do
        it 'sets the number of players' do
          g.minimum_number_of_players.should eq(2)
          g.maximum_number_of_players.should eq(4)
        end
      end
      
      describe '#full?' do
        it 'returns true if max players in game' do
          g.players = %w(a b c d)
          g.full?.should be_true
        end
        
        it 'returns false if more players can join' do
          g.players = %w(a b c)
          g.full?.should be_false
        end
      end
      
      describe '#ready?' do
        it 'returns true if enough players' do
          g.players = %w(player1 player2 player3)
          g.ready?.should be_true
        end
      end
    end
  end
end
