require_relative 'product'

class VendingMachine
  VALID_COINS = ['5', '10', '25']
  VALID_PRODUCTS = [Product.new('cola', 100),
                    Product.new('chips', 50),
                    Product.new('candy', 65)]

  attr_reader :coin_return, :hopper

  def initialize
    self.display = 'INSERT COIN'
    self.coins = []
    self.ready_to_reset = false
    self.ready_to_insufficient_payment_reset = false
    self.payment_sufficient = false
  end

  def display
    handle_insufficient_payment_state
    handle_purchase_completed_state
    @display
  end

  def insert coin
    if VALID_COINS.include? coin
      coins.push(coin)
      self.display = "#{total} cents"
    else
      self.coin_return = coin
    end
  end

  def button product_name
    @product_name = product_name
    select_product
    vend
  end

  private

  attr_reader :coins,
              :product,
              :ready_to_reset,
              :ready_to_insufficient_payment_reset,
              :payment_sufficient

  attr_writer :display,
              :coin_return,
              :coins,
              :product,
              :hopper,
              :ready_to_reset,
              :ready_to_insufficient_payment_reset,
              :payment_sufficient

  def select_product
    name_match = -> (p) { p.name == @product_name }
    self.product = VALID_PRODUCTS.select(&name_match).first
  end

  def vend
    return unless product
    dispense_product
    make_change
    update_display
  end

  def update_display
    self.display = payment_sufficient? ? 'THANK YOU' : "PRICE #{product.price}"
  end

  def dispense_product
    self.hopper = product if payment_sufficient?
  end

  def make_change
    return if total <= product.price
    coins.sort! {|a,b| b.to_i <=> a.to_i}
    coin_values = coins.map(&:to_i)
    remainder = 0
    used_coins = []
    coin_values.each do |coin|
      remainder = product.price - (used_coins.inject(:+) || 0) - coin
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

  def total
    coins.map(&:to_i).inject(:+) || 0
  end

  def payment_sufficient?
    @payment_sufficient ||= total >= product.price
  end

  def handle_insufficient_payment_state
    if ready_to_insufficient_payment_reset
      self.display = total > 0 ? "#{total} cents" : 'INSERT COIN'
      self.ready_to_insufficient_payment_reset = false
    end
    self.ready_to_insufficient_payment_reset = true if @display.start_with? 'PRICE'
  end

  def handle_purchase_completed_state
    initialize if ready_to_reset
    self.ready_to_reset = true if @display == 'THANK YOU'
  end
end
