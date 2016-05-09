FactoryGirl.define do
  factory :product do
    title  { Faker::Name.name }
    description {Faker::Lorem.word}
    price 1
    quantity 10
    # after(:build) do |product, eval|
    # 	product.photo << FactoryGirl.build(:image, product_id: product.id)
    # end
  end

  factory :user do
  	email { Faker::Internet.email }
  	password 1234567
  	password_confirmation 1234567
  	is_admin true

  end

  # factory :image do
  #  product :product
  #   file File.open(File.join(Rails.root, '/spec/files/img.png'))
  # end

end
