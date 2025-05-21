class UpdateIndexes < ActiveRecord::Migration[8.0]
  def change
    add_index :carts, [ :user_id, :status ]
    add_column :carts, :actual_price, :decimal, precision: 10, scale: 2
    add_reference :order_details, :cart, foreign_key: true
    add_column :order_details, :actual_price, :decimal, precision: 10, scale: 2
    drop_table :cart_details
  end
end
