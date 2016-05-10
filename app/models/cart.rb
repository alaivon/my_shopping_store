class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product)
  	current_item = cart_items.find_by(product_id: product.id)
  	if current_item
  		current_item.quantity +=1
  	else
	  	current_item = cart_items.build(product_id: product.id, price: product.price)
      cart_items << current_item
	  end
	  current_item
  end

  def total_price
  	items.inject(0){|sum, item| item.price}
  end


end
