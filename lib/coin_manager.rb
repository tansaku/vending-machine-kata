require_relative 'coin'

class CoinManager
  VALID_COINS = [Coin::NICKEL, Coin::DIME, Coin::QUARTER]

  attr_reader :coin_return

  def initialize
    self.coins = []
  end

  def total coin_array = coins
    coin_array.map(&:value).inject(:+) || 0
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
    coins.sort! { |a,b| b.value <=> a.value }
    remainder = 0
    used_coins = []
    while true  
      coin = coins[0]
      remainder = price - total(used_coins) - coin.value
      break if remainder < 0
      used_coins << coins.shift
    end
    coins.delete coins.select { |c| c.value == -remainder }
    self.coin_return = coins.first
  end
  
  private

  attr_accessor :coins
  attr_writer :coin_return
end
