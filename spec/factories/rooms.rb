# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :room do
    to_create { |instance| instance.commit }
  end
end
