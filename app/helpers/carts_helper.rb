module CartsHelper
	def render_cart_total(cart)
		number_to_currency(cart.total_price)
	end
end
