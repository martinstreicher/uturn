FactoryGirl.define do
  factory :room do
    name    { Faker::Lorem.words(2).join }
    
    factory :owned_room do
      owner { FactoryGirl.create(:user).id }
    end
  end
end
