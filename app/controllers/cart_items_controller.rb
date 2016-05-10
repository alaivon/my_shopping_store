class CartItemsController < ApplicationController
	def destroy
		@cart_item = @current_cart.cart_items.find(params[:id])
		@cart_item.destroy
		redirect_to :back
	end
end
