class HomeController < ApplicationController
  def index
    @order = Order.all
    @profit = @order.total_amount
    @orders_created = @order.count
    @orders_approved = @order.completed.count
    @orders_pending = @order.pending.count
    @orders_cancelled = @order.cancelled.count
    @suppliers = Supplier.all.count
    @products = Product.all.count
  end

  def update_session_supplier
    session[:supplier] = params[:supplier]
    redirect_to root_path
  end
end
