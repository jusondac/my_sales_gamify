class ShopController < ApplicationController
  def index
    @products = Product.all
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:category, :supplier)
  end
end
