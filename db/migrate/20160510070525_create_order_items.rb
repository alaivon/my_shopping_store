class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.string :name
      t.integer :price
      t.integer :quantity

      t.timestamps null: false
    end
    add_index :order_items, :order_id
  end
end
