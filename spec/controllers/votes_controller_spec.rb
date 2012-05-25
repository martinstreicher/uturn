require 'spec_helper'

describe VotesController do
  describe 'Methods' do
    describe 'POST create' do
      let(:p) { create :play_with_answers }
      
      it 'casts a vote' do
        votee = p.players.first
        votes = p.votes[votee]
        post :create, play_id: p.id, player_id: votee
        assigns[:play].id.should == p.id
        assigns[:player].should == votee
        p.votes[votee].should eq(votes + 1)
        response.body.should == "1"
      end
      
      it 'rejects a vote for a non-extant player' do
        post :create, play_id: p.id, player_id: 'mrx'
        response.status.should eq(UNPROCESSABLE_ENTITY)
      end
    end
  end
end
