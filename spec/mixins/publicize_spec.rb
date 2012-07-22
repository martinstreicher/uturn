require 'spec_helper'

class PublicizeDemo < Basis
  include Redis::Objects
  include Publicize  
end

describe PublicizeDemo do
  describe 'Instance Methods' do
    
    let(:p) {PublicizeDemo.create}
    
    describe '#privatize!' do 
      it 'with no args, sets status to private' do
        p.privatize!
        p.private?.should be_true
      end
      
      it 'with args, sets status and enrollment list' do
        p.privatize! :a, :b, :c
        p.enrollment.to_set.should == %w(a b c).to_set
      end
    end

    describe '#publicize!' do 
      it 'sets status to public' do
        p.publicize!
        p.public?.should be_true
      end
    end
  end
end
