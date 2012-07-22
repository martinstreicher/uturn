require 'spec_helper'

class PublicizeDemo < Basis
  include Redis::Objects
  include Publicize  
end

describe PublicizeDemo do
  describe 'Instance Methods' do
    
    let(:p) {PublicizeDemo.create}
    
    describe '#enroll' do
      it 'raises an exception area is public' do
        lambda {p.enroll :a}.should raise_exception
      end
      
      it 'adds to enrollment in private area' do
        p.privatize! :a
        p.enroll :b, :c
        p.enrollment.to_set.should == Set.new(['a', 'b', 'c'])
      end
    end
    
    describe '#enrollment=' do
      it 'raises an exception if area is public' do
        lambda {p.enrollment = :a}.should raise_exception
      end
      
      it 'sets the enrollment in a private area' do
        p.privatize!
        list = %w(a b c)
        p.enrollment = list
        p.enrollment.to_set.should == list.to_set
      end
    end
    
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
      
      it 'clears enrollment list' do
        p.privatize! :a, :b, :c
        p.publicize!
        p.enrollment.should be_empty
      end
    end
    
    describe '#<<' do
      it 'limits what players can join' do
        p.privatize! :x, :y, :z
        p.players = [:x, :y, :a]
        p.players.to_set.should == %w(x y).to_set
      end
    end
  end
end
