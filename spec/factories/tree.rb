FactoryGirl.define do
  factory :tree, :class => 'Tree' do
    area { Faker::Name.title}
    nota { Faker::Number.decimal(2, 3) }
  end
end
