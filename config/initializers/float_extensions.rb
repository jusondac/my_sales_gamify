class Float
  def to_price
    number_with_delimiter(self.to_i, delimiter: ".", separator: ",", format: "%n %u", unit: "€")
  end
end
