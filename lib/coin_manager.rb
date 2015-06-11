class CoinManager
  VALID_COINS = %w{5 10 25}

  attr_reader :coin_return

  def initialize
    self.coins = []
  end

  def total
    coins.map(&:to_i).inject(:+) || 0
  end

  def insert coin
    if VALID_COINS.include? coin
      coins.push(coin)
      true
    else
      self.coin_return = coin 
      false
    end
  end

  def make_change price
    return if total <= price
    coins.sort! {|a,b| b.to_i <=> a.to_i}
    coin_values = coins.map(&:to_i)
    remainder = 0
    used_coins = []
    coin_values.each do |coin|
      remainder = price - (used_coins.inject(:+) || 0) - coin
      break if remainder < 0
      used_coins << coin
    end
    used_coins.each do |coin| 
      coins.delete_at(coin_values.index(coin)) 
      coin_values.delete_at(coin_values.index(coin))
    end
    coins.delete_at(coin_values.index(-remainder))
    self.coin_return = coins.first
  end
  
  private

  attr_accessor :coins
  attr_writer :coin_return
end
