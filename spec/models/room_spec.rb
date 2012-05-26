require 'spec_helper'

describe Room do
  let(:r)   { create :room, name: 'Test' }
  
  describe 'Instance Methods' do
    describe '#game' do
      it 'spawns a new game with the given name' do
        name = Faker::Lorem.words(3).join
        g = r.game name
        g.name.should == name
        r.games.include?(g.id).should be_true
      end
    end
    
    describe '#games' do
      it 'returns all the games in the room' do
        names = (1..4).to_a.map {Faker::Lorem.words(3).join}
        games = names.map {|n| r.game n}
        r.games.to_set.should eq games.map(&:id).to_set
        games.map(&:name).to_set.should eq names.to_set
      end
    end
    
    describe '#name' do
      it 'returns the assigned name' do
        r.name.should == 'Test'
      end
    end
    
    describe '#name=' do
      it 'sets the name to the specified string' do
        r.name = 'mrx'
        r.name.should == 'mrx'
      end
    end
  end    
end
