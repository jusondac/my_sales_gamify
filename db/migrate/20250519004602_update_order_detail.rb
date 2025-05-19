class UpdateOrderDetail < ActiveRecord::Migration[8.0]
  def change
    add_column :order_details, :quantity, :integer
    add_column :order_details, :unit_price, :float
    add_column :order_details, :total, :float
    remove_column :order_details, :service_fee
    remove_column :order_details, :discount
    remove_column :order_details, :payment_id

    add_column :orders, :service_fee, :float
    add_column :orders, :discount, :float
    add_column :orders, :payment_id, :integer
  end
end
