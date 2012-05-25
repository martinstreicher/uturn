require 'spec_helper'

describe Game do
  describe 'Attributes' do
    describe 'plays' do
      it 'records the IDs of plays in the game' do
        
      end
    end
  end
  
  describe 'Factories' do
    it 'create a game' do
      g = create :game
      g.id.should_not be_nil
    end
  end
  
  describe 'Methods' do
    let(:g)   { Game.new maximum_number_of_players: 4, name: 'Test'}

    describe 'Instance Methods' do
      describe '#initialize' do
        it 'sets a default name' do
          g.name.should == 'Test'
        end
        
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
      
      describe '#play' do
        it 'returns a new play' do
          list = (1..4).map { g.play }
          g.plays.size.should eq(4)
          g.plays.values.to_set.should == list.map(&:id).to_set
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
