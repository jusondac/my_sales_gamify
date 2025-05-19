class UpdateOrderDetail < ActiveRecord::Migration[8.0]
  def change
    add_column :order_details, :quantity, :integer
		add_column :order_details, :unit_price, :float
		add_column :order_details, :total, :float
  end
end
