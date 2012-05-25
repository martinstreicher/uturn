require 'spec_helper'

describe Play do
  describe 'Attributes' do
    it 'has sorted set for votes' do
      p = Play.new
      p.votes['A'] = 3
      p.votes['B'] = 2
      p.votes.should == %w(B A)
      p.votes.members.to_set.should == %w(A B).to_set
    end
  end

  describe 'Factories' do
    it ':play sets players' do
      p = create :play
      p.players.all? {|player| player =~ /^player/ }
    end
    
    it ':play_with_answers creates answers' do
      p = create :play_with_answers
      p.players.all? { |player| p.answers[player].present? }
    end
    
    it ':play_with_votes creates answers and votes' do
      p = create :play_with_votes
      p.players.all? { |player| p.votes[player].present? }
    end    
  end
  
  describe 'Methods' do
    let(:p)   { Play.new }

    describe 'Class Methods' do
    end

    describe 'Instance Methods' do
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
