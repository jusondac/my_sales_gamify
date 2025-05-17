class UpdateSupplier < ActiveRecord::Migration[8.0]
  def change
    add_column :suppliers, :email, :string
		add_column :suppliers, :address, :string
		add_column :suppliers, :phone_number, :string
    add_reference :suppliers, :user, foreign_key: true
  end
end
