class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.integer :status
      t.float :total_price, default: 0.0
      t.float :fee, default: 0.0
      t.float :discount, default: 0.0
      t.references :order, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
