class HomeController < ApplicationController
  def index
    @order = Order.all
    @profit = @order.total_amount
    @order_created = @order.count
    @orders_approved = @order.completed.count
    @orders_pending = @order.pending.count
    @orders_cancelled = @order.cancelled.count
  end
end
