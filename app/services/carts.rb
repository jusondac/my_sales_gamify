class Carts
  def self.my_carts(user)
    cart = user.carts.where(status: 0).last
    cart.nil? ? Cart.create(user: user, status: 0) : cart
  end

  def self.add(product_id, quantity = 1, user)
    cart = my_carts(user)
    product = Product.find(product_id)
    OrderDetail.create!(
      cart_id: cart.id,
      product: product,
      quantity: quantity,
      unit_price: product.price,
      total: product.price * quantity
    )
    update_cart(cart)
  end

  def self.remove(product_id, user)
    cart = Cart.where(user: user, status: 0).last
    OrderDetail.find_by(cart: cart, product_id: product_id)&.destroy
    update_cart(cart)
  end

  def self.decrement(product_id, user)
    cart = my_carts(user)
    order_detail = cart.order_details.find_by(product_id: product_id)
    return unless order_detail

    if order_detail.quantity > 1
      order_detail.update(
        quantity: order_detail.quantity - 1,
        total: order_detail.product.price * (order_detail.quantity - 1)
      )
    else
      order_detail.destroy
    end
    update_cart(cart)
  end

  def self.increment(product_id, user)
    cart = my_carts(user)
    order_detail = cart.order_details.find_by(product_id: product_id)
    return unless order_detail
    new_quantity = order_detail.quantity + 1
    order_detail.update(
      quantity: new_quantity,
      total: order_detail.product.price * new_quantity
    )
    update_cart(cart)
  end

  def self.checkout(user, payment_id)
    cart = my_carts(user)
    OrderService.create_order(cart, user, payment_id)
  end


  def self.update_cart(cart)
    total_price     = 0
    fee             = 5
    cart.order_details.each do |order_detail|
      total_price += order_detail.quantity * order_detail.product.price
    end
    actual_price    = total_price
    discount        = 0.2 * total_price.to_f.round(2)
    total_product   = cart.order_details.count
    fee             = total_product > 0 ? fee : 0
    total_price     = total_price + fee - discount
    cart.update(
      actual_price: actual_price,
      total_price: total_price,
      fee: fee,
      discount: discount
    )
  end
end
