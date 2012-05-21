require 'spec_helper'

describe AnswersController do
  describe 'Private Methods' do
    let(:ps)  { %w(player1 player3) }
    let(:p)   { create :play, players: ps }
    
    describe '.fetch_params' do
      it 'assigns @play and @player var based on ID params' do
        post :create, play_id: p.id, player_id: ps.first, answer: 'banana'
        assigns[:play].id.should == p.id
        assigns[:player].should == 'player1'
        assigns[:answer].should == 'banana'
        response.location.should_not == nil
      end
    end
  end
end
