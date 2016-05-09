require 'rails_helper'

RSpec.describe Product, type: :model do
	it 'is accessible' do
		product = create(:product)
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

	describe 'validates' do
		it 'presence of title, description, price and quantity' do
			@product = create(:product)
			expect(Product.new).not_to be_valid
			expect(@product).to be_valid
		end
		it 'price & quantity must greater than or equal 1' do
			@product1 = Product.new(title: "title1", description: "description1", price: 1, quantity: 0)
			@product2 = Product.new(title: "title2", description: "description1", price: 0, quantity: 1)
			@product3 = create(:product)
			expect(@product1).to be_invalid
			expect(@product2).to be_invalid
			expect(@product3).to be_valid
		end
		it 'test title must be unique' do
			@product4 = create(:product)
			@product5 = Product.new(title: @product4.title, description: "test data", price: 1, quantity: 2)
			expect(@product5).not_to be_valid
			expect(@product5).to be_invalid
		end
	end

	it 'has photo' do
		product = create(:product)
		photo = Photo.create(product_id: product.id)
		# photo = Photo.create(image: "apple", product_id: product.id)
		expect(product.photo).to eq(photo)
	end


end