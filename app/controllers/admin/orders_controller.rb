class Admin::OrdersController <  AdminController
  

  def index
    @orders = Order.order("created_at DESC")
  end

  def show
    @order = Order.find(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    redirect_to :back
  end

  def arrived
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel!
    redirect_to :back
  end

  def return
    @order = Order.find(params[:id])
    @order.return!
    redirect_to :back
  end


end
