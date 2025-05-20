class Carts
  def self.my_carts(user)
    @cart = Cart.where(user: user, status: :active).first_or_create
    @cart
  end

  def self.add(product_id, quantity = 1, user)
    cart = Cart.where(user: user, status: 0).last
    product = Product.find(product_id)
    CartDetail.create(
      cart: cart,
      product: product,
      quantity: quantity,
      total_price: product.price * quantity
    )
  end

  def self.remove(product_id, user)
    cart = Cart.where(user: user, status: 0).last
    product = Product.find(product_id)
    CartDetail.where(cart: cart, product: product).first.destroy
  end
end
