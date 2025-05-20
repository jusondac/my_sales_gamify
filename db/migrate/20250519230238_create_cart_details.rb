class CreateCartDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_details do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :status
      t.integer :quantity
      t.float :total_price

      t.timestamps
    end
  end
end
