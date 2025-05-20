class Cart::CreateCarts
  def call
    @cart = Cart.where(user_id: Current.user.id, status: :active).first_or_create
    @cart
  end
end
