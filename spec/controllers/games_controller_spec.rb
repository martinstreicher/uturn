require 'spec_helper'

describe GamesController do
  describe 'Methods' do
    describe 'POST create' do
      let(:r) { create :room }
      
      it 'creates a game' do
        post :create, room_id: r.id, name: 'Test'
        game = assigns[:game]
        game.should_not be_nil
        game.name.should == 'Test'
        response.location.should == game_url(game.id)
      end
    end
    
    describe 'GET show' do
      let(:g) { create :game_with_players }
      
      it 'shows the specified game' do
        get :show, id: g.id
        game = assigns[:game]
        game.id.should == g.id
        response.status.should eq OK
        JSON.parse(response.body).values.first.keys.
          to_set.should == %w(name id players).to_set
      end
      
      it 'returns :not_found if game is not extant' do
        get :show, id: 'mrx'
        response.status.should eq NOT_FOUND
      end
    end
    
    describe 'PUT update' do
      let(:r) { create :room }
      let(:s) { create :room }
      let(:g) { r.game Faker::Lorem.words(3).join }
      
      it 'changes the game name if the game exists' do
        put :update, room_id: r.id, id: g.id, name: 'newname'
        game = assigns[:game]
        name = assigns[:name]
        name.should == 'newname'
        game.name.should == name
        response.status.should eq OK
      end
      
      it 'does nothing if the game does not exist' do
        put :update, room_id: s.id, id: g.id, name: 'error'
        response.status.should eq NOT_FOUND
      end
    end
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
