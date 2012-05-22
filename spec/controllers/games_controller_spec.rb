require 'spec_helper'

describe GamesController do
  describe 'Methods' do
  end
  
  describe 'Private Methods (in Application Controller)' do
    let(:ps)  { %w(player1 player3) }
    let(:r)   { create :room, players: ps }
    let(:g)   { create :game, players: ps }
    
    describe '.fetch_params' do
      it 'assigns @game var based on ID param' do
        get :show, room_id: r.id, id: g.id
        assigns[:game].id.should == g.id
        assigns[:game].players.to_set.should == ps.to_set
      end
      
      it 'assigns @room var based on room_id param' do
        get :show, room_id: r.id, id: g.id
        assigns[:room].id.should == r.id
        assigns[:room].players.to_set.should == r.players.to_set
      end      
    end
  end
end
