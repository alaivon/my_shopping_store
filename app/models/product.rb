class Product < ActiveRecord::Base
	has_many :cart_items
	validates :title, :description, :price, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 1}, allow_blank: true
	validates :title, uniqueness: true
  before_destroy :ensure_not_add_in_cart
	has_one :photo
	accepts_nested_attributes_for :photo





	private

	def ensure_not_add_in_cart
		unless cart_items.empty?
			errors.add(:base, 'Cart Items present')
			throw :abort
		end
	end



end
