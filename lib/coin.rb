class Coin
  def initialize representation
    self.representation = representation
  end

  def value
    representation.to_i
  end

  private

  attr_accessor :representation

  public

  PENNY = self.new '1'
  NICKEL = self.new '5'
  DIME = self.new '10'
  QUARTER = self.new '25'

end
