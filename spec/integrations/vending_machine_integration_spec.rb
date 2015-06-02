require 'vending_machine'

# As a vendor
# I want a vending machine that accepts coins
# So that I can collect money from the customer

describe VendingMachine do
  it 'can handle a sequence of invalid and valid coins' do
    subject.insert 'llama'
    expect(subject.display).to eq 'INSERT COIN'
    expect(subject.coin_return).to eq 'llama'
    subject.insert '1'
    expect(subject.display).to eq 'INSERT COIN'
    expect(subject.coin_return).to eq '1'
    subject.insert '5'
    expect(subject.display).to eq '5 cents'
    subject.insert '25'
    expect(subject.display).to eq '30 cents'
  end
  it 'dispense a product' do
    subject.insert '25'
    subject.insert '25'
    subject.insert '25'
    subject.insert '25'
    subject.button 'cola'
    expect(subject.hopper.name).to eq 'cola'
    expect(subject.display).to eq 'THANK YOU'
    expect(subject.display).to eq 'INSERT COIN'
    class VendingMachine; attr_reader :coins; end
    expect(subject.coins).to eq []
  end
end