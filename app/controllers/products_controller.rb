class ProductsController < ApplicationController
	include CurrentCart
	before_action :set_cart
	before_action :authenticate_user!, only: [:add_to_cart]

	def index
		@products = Product.where(on_sale: true)
	end

	def show
		
		@product = Product.friendly.find(params[:id])
    set_page_title @product.title
		@comments = @product.comments.order("created_at DESC")
		if @comments.blank?
      @avg_rating = 0
    else
      @avg_rating = @comments.average(:rating).round(2)
    end
	end


	def add_to_cart
		@product = Product.friendly.find(params[:id])
		@cart_item = @current_cart.add_product_to_cart(@product)
		if @cart_item.save
			redirect_to :back, notice: "You add #{@product.title} to your cart"
		else
			render :show
		end
	end
end
