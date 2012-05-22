require 'spec_helper'

describe AnswersController do
  let(:ps)  { %w(player1 player3) }
  let(:p)   { create :play, players: ps }
  
  describe 'Methods' do
    describe 'POST create' do
      before :each do 
        post :create, play_id: p.id, player_id: ps.first, answer: 'banana'
      end
      
      describe 'API results' do
        it 'yields location' do
          response.location.should == play_player_vote_url(p.id, ps.first)        
        end
      
        it 'returns CREATED' do
          response.status.should eq(CREATED)
        end
      end
      
      describe 'Logic' do
        it 'assigns @answer' do
          assigns[:answer].should == 'banana'
        end
        
        it 'records the user\'s answer' do
          p.answers[ps.first].should == 'banana'
        end     
        
        it 'ignores the answer if the user does not exist in play' do
          post :create, play_id: p.id, player_id: 'mrx', answer: 'cheese'
          response.status.should eq(UNPROCESSABLE_ENTITY)
        end 
      end
    end
  end
  
  describe 'Private Methods (in Application Controller)' do
    describe '.fetch_params' do
      it 'assigns @play and @player var based on ID params' do
        post :create, play_id: p.id, player_id: ps.first, answer: 'banana'
        assigns[:play].id.should == p.id
        assigns[:player].should == 'player1'
      end
    end
  end
end
