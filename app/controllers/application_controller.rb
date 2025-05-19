class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Authentication
  include SvgIconsHelper
  include ApplicationHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :sidebar_menu
  before_action :set_supplier

  def sidebar_menu
    @sidebar_menus = [
      { name: "Dashboard", path: "/", icon: dashboard, role: "admin user supplier" },
      { name: "Shop", path: "/shop", icon: shops, role: "admin user supplier" },
      { name: "Orders", path: "/orders", icon: orders, role: "admin user supplier" },
      { name: "Suppliers", path: "/suppliers", icon: orders, role: "admin user" },
      {
        name: "Product", icon: products, role: "supplier", submenu: [
          { name: "Products", path: "/products" },
          { name: "Inventory", path: "/inventories" },
          { name: "Category", path: "/categories" }
        ]
      },
      { name: "Order details", path: "/order_details", icon: order_details, role: "admin user supplier" },
      { name: "Payments", path: "/payments", icon: payments, role: "admin user supplier" }
    ]
  end

  def set_supplier
    @current_supplier = Supplier.find(session[:supplier]) unless session[:supplier].nil?
  end
end
