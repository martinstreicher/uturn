# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :play do
    to_create { |instance| instance.commit }
  end
end
