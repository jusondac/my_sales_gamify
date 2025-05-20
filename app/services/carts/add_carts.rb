class Carts::AddCarts
  def self.call(product_id, quantity = 1, user)
    cart = Cart.where(user: user, status: 0).last
    product = Product.find(product_id)
    CartDetail.create(
      cart: cart,
      product: product,
      quantity: quantity,
      total_price: product.price * quantity
    )
  end
end
