FactoryGirl.define do
  sequence :players do |n|
    (1..4).map  { "player:#{UUID.generate}" }
  end
  
  factory :play do
    players     { FactoryGirl.generate :players }
    
    factory :play_with_answers do 
      answers   { |me|
        me.players.inject({}) { |result, value|
          result[value] = Faker::Lorem.sentences.join; result } }
          
        factory :play_with_votes do
          votes { |me|
            me.players.inject({}) { |result, value|
              result[value] = (0..99).to_a.sample; result } }
        end
    end
  end
end
