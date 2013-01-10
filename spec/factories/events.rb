# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    start_date "2013-01-03"
    end_date "2013-01-03"
    price 1
  end
end
