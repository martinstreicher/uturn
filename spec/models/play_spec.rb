require 'spec_helper'

describe Play do
  describe 'Attributes' do
    it 'has a unique ID' do
      p = Play.new
      q = Play.new
      p.id.should_not == q.id
    end

    it 'has sorted set for votes' do
      p = Play.new
      p.votes['A'] = 3
      p.votes['B'] = 2
      p.votes.should == %w(B A)
      p.votes.members.to_set.should == %w(A B).to_set
    end
  end

  describe 'Methods' do
    let(:p)   { Play.new }

    describe 'Class Methods' do
      describe '.find' do
        it 'finds existing records' do
          p << 'A'
          q = Play.find p.id
          q.should_not be_nil
          q.players.should == %w(A)
        end

        it 'does not find "new" records' do
          q = Play.find p.id
          q.should be_nil
        end
      end
    end

    describe 'Instance Methods' do
      describe '<< or add_players' do
        it '<< adds to the list of players' do
          p << ['A', 'B']
          p.players.to_set.should == %w(A B).to_set
        end

        it 'add_players adds to the list of players' do
          p.add_players 'A', 'B', 'C'
          p.players.to_set.should == %w(A B C).to_set

          p.add_players %w(X Y Z)
          p.players.to_set.should == %w(A B C X Y Z).to_set
        end
      end

      describe 'players=' do
        it 'sets the players' do
          p.add_players %w(X Y Z)
          p.players = %w(A B C)
          p.players.to_set.should == %w(A B C).to_set
        end
      end

      describe '#record_answer' do
        it 'ignores an answer if player does not exist' do
          p.record_answer 'A', 'apple'
          p.answers['A'].should == nil
          p.answers.all.keys.should == []
        end

        it 'records a players answer' do
          p << 'A'
          p.record_answer 'A', 'apple'
          p.answers['A'].should == 'apple'
        end
      end

      describe '#vote_for' do
        it 'ignores a vote if player does not exist' do
          p.vote_for('A')
          p.votes['A'].should == NULL
        end

        it 'increments a players votes' do
          p << 'A'
          p.votes['A'] = 1
          p.vote_for('A')
          p.votes['A'].should == 2
        end
      end
    end
  end
end
