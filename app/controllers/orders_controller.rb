class OrdersController < ApplicationController
	include CurrentCart
	before_action :authenticate_user!
	before_action :set_cart

	def new
		if @current_cart.cart_items.empty?
			flash[:warning] = "Your cart is empty!"
			redirect_to products_url
		else
			@order = current_user.orders.build
			@info = @order.build_info
		end
	end

	def create
		@order = current_user.orders.build(order_params)
		if @order.save
			@order.add_items_from_cart(@current_cart)
			@order.calculate_total!(@current_cart)
			redirect_to root_url
		else
			render :new
		end
	end

	def show
		@order = current_user.orders.find(params[:id])
		@info = @order.info
		@order_items = @order.items
	end



	private

	def order_params
		params.require(:order).permit(info_attributes: [:billing_name, :billing_address, 
																										:shipping_name, :shipping_address])
	end



end
