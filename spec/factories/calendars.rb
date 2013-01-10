# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar do
    title "MyString"
    start_date "2012-12-27 10:56:02"
    end_date "2012-12-27 10:56:02"
    resource_id 1
  end
end
