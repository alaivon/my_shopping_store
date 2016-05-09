class ProductsController < ApplicationController
	before_action :set_cart
	include CurrentCart

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
	end


	def add_to_cart
		@product = Product.find(params[:id])
		@current_cart.add_product_to_cart(@product)
		redirect_to :back
	end
end
