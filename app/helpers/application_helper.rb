module ApplicationHelper
  include Pagy::Frontend

  class Float
    def to_price
      format("%.2f", self)
    end
  end
end
