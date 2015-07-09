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
    valid = VALID_COINS.include? coin
    valid ? coins.push(coin) : self.coin_return = coin
    valid
  end

  def make_change price
    return if total <= price
    remainder = calculate_remainder_from price
    coins.delete coins.select { |coin| coin.value == -remainder }
    self.coin_return = coins.first
  end

  private

  def calculate_remainder_from price
    loop do
      remainder = price - total(used_coins) - coins.first.value
      return remainder if remainder < 0
      used_coins << coins.shift
    end
  end

  def used_coins
    @used_coins ||= []
  end

  attr_accessor :coins
  attr_writer :coin_return
end
