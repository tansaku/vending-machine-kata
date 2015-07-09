class Coin
  def initialize representation
    self.representation = representation
  end

  def value
    representation.to_i
  end

  private

  attr_accessor :representation

  PENNY = new '1'
  NICKEL = new '5'
  DIME = new '10'
  QUARTER = new '25'
end
