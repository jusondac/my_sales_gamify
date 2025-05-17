class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Authentication
  include SvgIconsHelper
  include ApplicationHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :sidebar_menu

  def sidebar_menu
    @sidebar_menus = [
      { name: "Dashboard", path: "/", icon: dashboard },
      { name: "Orders", path: "/orders", icon: orders },
      { name: "Suppliers", path: "/suppliers", icon: orders },
      {
        name: "Product", icon: products, submenu: [
          { name: "Products", path: "/products" },
          { name: "Inventory", path: "/inventories" },
          { name: "Category", path: "/categories" }
        ]
      },
      { name: "Order details", path: "/order_details", icon: order_details },
      { name: "Payments", path: "/payments", icon: payments }
    ]
  end
end
