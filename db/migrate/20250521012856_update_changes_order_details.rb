class UpdateChangesOrderDetails < ActiveRecord::Migration[8.0]
  def change
    change_column_null :order_details, :order_id, true
    add_column :orders, :actual_price, :decimal, precision: 10, scale: 2
  end
end
