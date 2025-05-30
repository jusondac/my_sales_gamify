class CreateOrderDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true
      t.float :discount
      t.integer :service_fee

      t.timestamps
    end
  end
end
