class CreateOrderInfos < ActiveRecord::Migration
  def change
    create_table :order_infos do |t|
      t.integer :order_id
      t.string :billing_address
      t.string :billing_name
      t.string :shipping_name
      t.string :shipping_address

      t.timestamps null: false
    end
    add_index :order_infos, :order_id
  end
end
