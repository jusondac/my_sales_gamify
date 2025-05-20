class ShopController < ApplicationController
  def index
    @products = Product.all
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:category, :supplier)
    @cart = Carts.my_carts(Current.user)
  end
end
