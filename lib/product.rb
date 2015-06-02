class Product
  
  attr_reader :name, :price

  def initialize name, price
    self.name = name
    self.price = price
  end

  private

  attr_writer :name, :price
end