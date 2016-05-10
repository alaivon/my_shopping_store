class OrdersController < ApplicationController
	include CurrentCart
	before_action :authenticate_user!
	before_action :set_cart, only: [:create, :new]

	def new
		
	end

	private

	def test_quantity
		
	end

end
