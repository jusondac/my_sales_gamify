class OrderService
  def self.create_order(cart, user, payment_id)
    ActiveRecord::Base.transaction do
       order = Order.create(
        user: user,
        amount: cart.total_price,
        status: 0,
        ordered_at: DateTime.now,
        service_fee: cart.fee,
        actual_price: cart.actual_price,
        discount: cart.discount,
        payment_id: payment_id
      )
      cart.update(status: 1, order: order)
      cart.order_details.update_all(order_id: order.id)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Order creation failed: #{e.message}")
      raise ActiveRecord::Rollback
    end
  end
end
