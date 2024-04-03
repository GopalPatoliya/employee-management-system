FactoryBot.define do
  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    department { Faker::Company.profession }
    salary { Faker::Number.between(from: 30000, to: 100000) }
  end
end
