module OrdersHelper
  def render_order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end

  def render_order_paid(order)
    if order.is_paid?
      "Paid"
    else
      "UnPaid"
    end
  end

end
