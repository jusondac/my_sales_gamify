class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :amount
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.datetime :ordered_at

      t.timestamps
    end
  end
end
