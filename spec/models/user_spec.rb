require 'spec_helper'

describe User do
  let(:u)   { create :user }
  let(:r)   { create :room, name: 'XXX'}
  
  describe 'Instance Methods' do
    describe '#room' do
      it 'returns the room' do
        u.room.should be_nil
        u.room = r
        u.room.id.should == r.id
      end
    end
    
    describe '#room=' do
      it 'sets the room' do
        u.room = r
        u.room.id.should == r.id
      end
    end    
  end
end