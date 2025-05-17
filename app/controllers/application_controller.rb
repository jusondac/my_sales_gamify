class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Authentication
  include SvgIconsHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :sidebar_menu

  def sidebar_menu
    @sidebar_menus = [
      { name: "Dashboard", path: "/", icon: dashboard },
      { name: "Orders", path: "/orders", icon: orders },
      {
        name: "Product", path: "#", icon: products, submenu: [
          { name: "Products", path: "#" },
          { name: "Inventory", path: "#" },
          { name: "Category", path: "#" }
        ]
      },
      {
        name: "History", icon: log, submenu: [
          { name: "history", path: "#" },
          { name: "refund", path: "#" },
          { name: "logistic", path: "#" }
        ]
      }
    ]
  end
end
