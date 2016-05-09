FactoryGirl.define do
	factory :product do
		title  { Faker::Name.name }
		description {Faker::Lorem.word}
		price 1
		quantity 10
		# is_admin true
	end
end