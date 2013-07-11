# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    name "MyString"
    code 1
    address "MyString"
    phone "MyString"
    postal "MyString"
    address_fetched false
  end
end
