class AddPriceToCartItems < ActiveRecord::Migration
  def up
    add_column :cart_items, :price, :integer
    CartItem.all.each do |item|
    	item.update(price: item.product.price)
    end
  end

  def down
  	remove_column :cart_items, :price
  end
end
