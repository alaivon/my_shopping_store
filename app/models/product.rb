class Product < ActiveRecord::Base
	validates :title, :description, :price, :quantity, presence: true
	validates :price, :quantity, numericality: {greater_than_or_equal_to: 1}, allow_blank: true
	validates :title, uniqueness: true
end
