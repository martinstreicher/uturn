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

    describe 'Instance Methods' do
      describe '#vote_for' do
        it 'ignores a vote if player does not exist' do
          p.vote_for('A')
          p.votes['A'].should == Play::NULL
        end

        it 'increments a players votes' do
          p.users << 'A'
          p.votes['A'] = 1
          p.vote_for('A')
          p.votes['A'].should == 2
        end
      end

      describe '#record_answer' do
        it 'ignores an answer if player does not exist' do
          p.record_answer 'A', 'apple'
          p.answers['A'].should == nil
          p.answers.all.keys.should == []
        end

        it 'records a players answer' do
          p.users << 'A'
          p.record_answer 'A', 'apple'
          p.answers['A'].should == 'apple'
        end
      end
    end
  end
end
