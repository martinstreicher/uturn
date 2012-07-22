require 'spec_helper'

describe Basis do
  describe 'Attributes' do
    it 'has a unique ID' do
      p = Basis.new
      q = Basis.new
      p.id.should_not == q.id
    end
  end

  describe 'Methods' do
    let(:b)   { Basis.new }

    describe 'Class Methods' do
      describe '.create' do
        it 'returns a new `saved` record' do
          b = Basis.create
          b.new_record?.should be_false
        end
      end
      
      describe '.find' do
        it 'finds existing records' do
          b << 'A'
          b.save
          q = Basis.find b.id
          q.should_not be_nil
          q.players.should == %w(A).to_set
        end

        it 'does not find "new" records' do
          q = Basis.find b.id
          q.should be_nil
        end
      end
    end

    describe 'Instance Methods' do
      describe '<< or add_players' do
        it '<< adds to the list of players' do
          b << ['A', 'B']
          b.players.should == %w(A B).to_set
        end

        it 'add_players adds to the list of players' do
          b.add_players 'A', 'B', 'C'
          b.players.should == %w(A B C).to_set

          b.add_players %w(X Y Z)
          b.players.should == %w(A B C X Y Z).to_set
        end
        
        it 'ignores banned players' do
          b.add_players 'A', 'B', 'C'
          b.boot :X, :Y
          b.add_players %w(X Y Z)
          b.players.should == %w(A B C Z).to_set
        end
      end

      describe 'banned' do
      end
      
      describe 'booted' do
        it 'removes players' do
          b.add_players %w(X Y Z)
          b.boot(:X)
          b.players.should == %w(Y Z).to_set
        end
        
        it 'records banned players' do
          b.add_players %w(X Y Z)
          b.boot(:X, :Y)
          b.banned.should == %w(X Y).to_set
        end
      end
      
      describe 'players=' do
        it 'sets the players' do
          b.add_players %w(X Y Z)
          b.players = %w(A B C)
          b.players.should == %w(A B C).to_set
        end
        
        it 'ignores banned players' do
          b.boot :X, :Y
          b.add_players %w(X Y Z)
          b.players.should == %w(Z).to_set
        end
      end
    end
  end
end
