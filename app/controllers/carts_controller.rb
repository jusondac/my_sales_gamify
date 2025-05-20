class CartsController < ApplicationController
  before_action :set_cart, only: [ :index, :add, :remove ]

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

  private

  def set_cart
    @cart = Cart.where(user_id: Current.user.id).first_or_create
  end
end
