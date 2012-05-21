require 'spec_helper'

describe GamesController do
  describe 'show' do
    it 'do' do
      r = create :room
      g = create :game
      result = get :show, room_id: r.id, id: g.id
      result.should == g
    end
  end
end
