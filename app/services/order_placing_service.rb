class OrderPlacingService
  def initialize(cart, order)
    @order = order
    @cart = cart
  end

  def place_order!
    @order.add_items_from_cart(@cart)
    @order.calculate_total!(@cart)
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    OrderMailer.notify_order_placed(@order).deliver
  end
end
