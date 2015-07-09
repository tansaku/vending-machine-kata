require_relative 'product'
require_relative 'coin_manager'

class VendingMachine
  VALID_PRODUCTS = [Product.new('cola', 100),
                    Product.new('chips', 50),
                    Product.new('candy', 65)]

  attr_reader :coin_return, :hopper

  def initialize coin_manager_klass = CoinManager
    self.display = 'INSERT COIN'
    self.coin_manager = coin_manager_klass.new
    self.ready_to_reset = false
    self.ready_to_reset_after_insufficient_payment = false
    self.payment_sufficient = false
  end

  def display
    handle_insufficient_payment_state
    handle_purchase_completed_state
    @display
  end

  def insert coin
    self.display = "#{coin_manager.total} cents" if coin_manager.insert coin
    self.coin_return = coin_manager.coin_return
  end

  def button product_name
    self.product_name = product_name
    select_product
    vend
  end

  private

  attr_writer :display,
              :coin_return,
              :hopper

 
  attr_accessor :product,
                :ready_to_reset,
                :ready_to_reset_after_insufficient_payment,
                :payment_sufficient,
                :product_name,
                :coin_manager

  alias_method :product_selected?, :product
  alias_method :ready_to_reset?, :ready_to_reset
  alias_method :ready_to_reset_after_insufficient_payment?, :ready_to_reset_after_insufficient_payment
  
  def select_product
    name_match = -> (p) { p.name == product_name }
    self.product = VALID_PRODUCTS.select(&name_match).first
  end

  def vend
    return unless product_selected?
    dispense_product
    coin_manager.make_change product.price
    self.coin_return = coin_manager.coin_return
    update_display
  end

  def update_display
    self.display = payment_sufficient? ? 'THANK YOU' : "PRICE #{product.price}"
  end

  def dispense_product
    self.hopper = product if payment_sufficient?
  end

  def payment_sufficient?
    self.payment_sufficient ||= coin_manager.total >= product.price
  end

  def handle_insufficient_payment_state
    if ready_to_reset_after_insufficient_payment?
      self.display = coin_manager.total > 0 ? "#{coin_manager.total} cents" : 'INSERT COIN'
      self.ready_to_reset_after_insufficient_payment = false
    end
    self.ready_to_reset_after_insufficient_payment = true if @display.start_with? 'PRICE'
  end

  def handle_purchase_completed_state
    initialize if ready_to_reset?
    self.ready_to_reset = true if @display == 'THANK YOU'
  end
end
