class Carts
  def self.my_carts(user)
    user.carts.strict_loading
               .includes(cart_details: { product: [ :category, :supplier ] })
               .find_or_initialize_by(status: 0)
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
    CartDetail.find_by(cart: cart, product_id: product_id)&.destroy
  end

  def self.decrement(product_id, user)
    cart = Cart.where(user: user, status: 0).last
    cart_detail = CartDetail.find_by(cart: cart, product_id: product_id)
    return unless cart_detail

    if cart_detail.quantity > 1
      cart_detail.update(
        quantity: cart_detail.quantity - 1,
        total_price: cart_detail.product.price * (cart_detail.quantity - 1)
      )
    else
      cart_detail.destroy
    end
  end

  def self.increment(product_id, user)
    cart = Cart.where(user: user, status: 0).last
    cart_detail = CartDetail.find_by(cart: cart, product_id: product_id)
    return unless cart_detail

    new_quantity = cart_detail.quantity + 1
    cart_detail.update(
      quantity: new_quantity,
      total_price: cart_detail.product.price * new_quantity
    )
  end
end
