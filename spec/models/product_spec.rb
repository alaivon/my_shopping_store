require 'rails_helper'

RSpec.describe Product, type: :model do
	it 'is accessible' do
		product = Product.create!
		expect(product).to eq(Product.last)
	end	

	it 'has right columns' do
		columns = Product.column_names
		expect(columns).to include("id")
		expect(columns).to include("price")
		expect(columns).to include("description")
		expect(columns).to include("quantity")
		expect(columns).not_to include("content")
	end
end