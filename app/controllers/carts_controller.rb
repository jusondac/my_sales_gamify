class CartsController < ApplicationController
  # before_action :set_cart, only: [ :index, :add, :remove ]
  before_action :load_supplier_status

  def index
    @cart = Carts.my_carts(Current.user)
  end

  def add
    @cart = Carts.add(params[:product_id], Current.user)
    redirect_to request.referer, notice: "Item added to cart successfully."
  end

  def remove
    @cart = Carts.remove(params[:product_id], Current.user)
    redirect_to request.referer, notice: "Item removed from cart successfully."
  end

  def decrement
    @cart = Carts.decrement(params[:product_id], Current.user)
    redirect_to request.referer
  end

  def increment
    @cart = Carts.increment(params[:product_id], Current.user)
    redirect_to request.referer
  end

  def checkout
    @cart = Carts.checkout(Current.user, params[:payment_method])
    redirect_to request.referer, notice: "Checkout successful! check your order in #{view_context.link_to('your Orders', orders_path, class: "underline").html_safe}."
  end

  private

  def load_supplier_status
    @is_supplier = Current.user.suppliers.exists?
  end
end
