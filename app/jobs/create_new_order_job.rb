class CreateNewOrderJob < ApplicationJob
  queue_as :default

  def perform
    rand(1..3).times do
      order = Order.create!(
        user_id: User.all.sample.id,
        status: 0,
        amount: rand(1..1000),
        ordered_at: DateTime.now,
      )
      Turbo::StreamsChannel.broadcast_replace_to(
        "orders",
        target: "orders",
        partial: "orders/order",
        locals: { order: order }
      )
    end
  end
end
