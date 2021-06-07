FactoryBot.define do
  factory :article do
    title       {Faker::Name.initials(number: 2)}
    category_id {rand(1..17)}
    text        {Faker::Lorem.sentence}

    association :user

    after(:build) do |article|
      article.images.attach(io: File.open('app/assets/images/paper_fibers.png'), filename: 'test_image.jpg')
    end
  end
end

