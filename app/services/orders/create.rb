# app/services/order_creator.rb
class Orders::Create 
  def self.call(params)

    order_details = params[:order][:order_details_attributes]

    order_details.each do |order_detail|
      OrderDetail.create!(
        product_id: order_detail[:product_id],
      )
    end
  end

  # def call
  #   Order.transaction do
  #     order = Order.create!(@order_params)
  #     add_products_to_order(order, @product_params)
  #     order
  #   end
  # rescue ActiveRecord::RecordInvalid => e
  #   # Handle validation errors
  #   raise e
  # end

  private

  def add_products_to_order(order, products_data)
    products_data.each do |product_data|
      order.products.create!(product_data)
    end
  end
end
