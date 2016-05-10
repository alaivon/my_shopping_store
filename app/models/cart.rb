class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
  	current_item = cart_items.find_by(product_id: product.id)
  	if current_item.quantity
  		current_item.quantity +=1
  	else
	  	current_item = cart_items.build(product_id: product.id, price: product.price)
      cart_items << current_item
	  end
	  current_item
  end

  def total_price
  	cart_items.inject(0){|sum, item| item.price * item.quantity}
  end


  def increse(cart_item_id)
    current_item = cart_items.find_by_id(cart_item_id)
    current_item.quantity +=1
    current_item
  end

  def decrese(cart_item_id)
    current_item = cart_items.find_by_id(cart_item_id)
    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end
    current_item
  end


end
