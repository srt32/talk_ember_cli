FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :contact_name do |n|
    "billy_bob_#{n}"
  end

  factory :user do
    email
    password 'foobar123!'
  end

  factory :contact do
    user
    name { generate(:contact_name) }
    frequency 7
  end

  factory :conversation do
    contact
  end

end
