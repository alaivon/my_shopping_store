class CartItemsController < ApplicationController
	def destroy
		@cart_item = @current_cart.cart_items.find(params[:id])
		@cart_item.destroy
		redirect_to :back
	end

	def decrement
    @cart_item = @current_cart.decrese(params[:id])
    respond_to do |format|
      if @cart_item.save
        format.html {redirect_to carts_url}
        format.js {@current_item = @cart_item}
        format.json {head :ok}
      else
        format.html {render :edit}
        format.json {render json: @cart_item.errors, status: :unprocessable_entity}
      end
    end
  end

    def increment
  	item = @current_cart.cart_items.find(params[:id])
  	if item.quantity < item.product.quantity
    	@cart_item = @current_cart.increse(params[:id])
    	respond_to do |format|
      	if @cart_item.save
        	format.html {redirect_to carts_url}
        	format.js 
        	format.json {head :ok}
      	else
        	format.html {render :index}
        	format.json {render json: @cart_item.errors, status: :unprocessable_entity}
     	 	end
 			end
    end
  end
end
