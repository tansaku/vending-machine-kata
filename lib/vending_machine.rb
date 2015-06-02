class VendingMachine

  VALID_COINS = ['5','10','25']

  attr_reader :display, :coin_return

  def initialize
    self.display = 'INSERT COIN'
    self.coins = []
  end

  def insert coin
    if VALID_COINS.include? coin
      self.coins.push(coin)
      self.display = "#{total} cents"
    else
      self.coin_return = coin
    end
  end

  protected

  attr_reader :coins

  private 

  def total
    self.coins.map(&:to_i).inject(:+)
  end

  attr_writer :display, :coin_return, :coins
end