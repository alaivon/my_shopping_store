class OrdersController < ApplicationController
  include CurrentCart
  before_action :authenticate_user!
  before_action :set_cart


  def index
    @orders = current_user.orders.order("created_at DESC")
  end

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
      OrderPlacingService.new(@current_cart, @order).place_order!
      redirect_to order_url(@order.token)
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find_by_token(params[:id])
    @info = @order.info
    @order_items = @order.items
  end

  def pay_by_card
    @order = current_user.orders.find_by_token(params[:id])
    @order.set_payment!('Credit Card')
    @order.make_payment!
    redirect_to orders_url, notice: "You pay it Successfully!"
  end



  private

  def order_params
    params.require(:order).permit(info_attributes: [:billing_name, :billing_address,
                                                    :shipping_name, :shipping_address])
  end



end
