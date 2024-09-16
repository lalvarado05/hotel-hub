FactoryBot.define do
  factory :room do
    name { "Room #{Faker::Number.unique.number(digits: 3)}" }
    price { 100.00 }
    available { true }

    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/sample_image.jpg'), 'image/jpg') rescue nil }

    after(:create) do |room|
      room.beds << create(:bed)
      room.services << create(:service)
    end
  end
end