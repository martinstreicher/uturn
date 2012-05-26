FactoryGirl.define do
  factory :game do
    
    factory :game_with_players do
      players   { FactoryGirl.generate :players }
    end
  end
end
