class Order < ActiveRecord::Base
	belongs_to :user
	has_many :items, class_name: 'OrderItem', dependent: :destroy
	has_one :info, class_name: 'OrderInfo', dependent: :destroy

	accepts_nested_attributes_for :info

	def add_items_from_cart(cart)
		cart.cart_items.each do |cart_item|
			item = items.build
			item.name = cart_item.product.title
			item.quantity = cart_item.quantity
			item.price = cart_item.price
			item.save
		end
	end

	def calculate_total!(cart)
		self.total = cart.total_price
		self.save
	end
end
