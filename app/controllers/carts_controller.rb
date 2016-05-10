class CartsController < ApplicationController
	include CurrentCart  
  before_action :authenticate_user!
	before_action :set_cart

  def show

  end

  def destroy
  	@current_cart.destroy if @current_cart.id == session[:cart_id]
  	session[:cart_id] = nil
  	redirect_to products_url, notice: "Your cart is empty now!"
  end


end
