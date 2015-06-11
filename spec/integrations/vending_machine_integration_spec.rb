require 'vending_machine'

describe VendingMachine do
  context 'Accept Coins Feature' do
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
  end
  context 'Select Product Feature' do
    it 'dispense a product (cola)' do
      subject.insert '25'
      subject.insert '25'
      subject.insert '25'
      subject.insert '25'
      subject.button 'cola'
      expect(subject.hopper.name).to eq 'cola'
      expect(subject.display).to eq 'THANK YOU'
      expect(subject.display).to eq 'INSERT COIN'
      # consider helper method TODO
      subject.button 'cola'
      expect(subject.display).to eq 'PRICE 100'
      expect(subject.display).to eq 'INSERT COIN'
    end
    it 'dispense another product (candy)' do
      subject.insert '25'
      subject.insert '25'
      subject.insert '10'
      subject.insert '5'
      subject.button 'candy'
      expect(subject.hopper.name).to eq 'candy'
      expect(subject.display).to eq 'THANK YOU'
      expect(subject.display).to eq 'INSERT COIN'
      # consider helper method TODO
      subject.button 'candy'
      expect(subject.display).to eq 'PRICE 65'
      expect(subject.display).to eq 'INSERT COIN'
    end
    it 'does not dispense a product with insufficient payment' do
      subject.insert '25'
      subject.insert '25'
      subject.button 'cola'
      expect(subject.display).to eq 'PRICE 100'
      expect(subject.display).to eq '50 cents'
    end
    it 'does not dispense a product with no payment' do
      subject.button 'cola'
      expect(subject.display).to eq 'PRICE 100'
      expect(subject.display).to eq 'INSERT COIN'
    end
    it 'dispense some chips if correct amount is given' do
      subject.insert '25'
      subject.insert '25'
      subject.button 'chips'
      expect(subject.hopper.name).to eq 'chips'
      expect(subject.display).to eq 'THANK YOU'
      expect(subject.display).to eq 'INSERT COIN'
      # consider helper method TODO
      subject.button 'chips'
      expect(subject.display).to eq 'PRICE 50'
      expect(subject.display).to eq 'INSERT COIN'
    end
    it 'will not allow the purchase of invalid products' do
      subject.button 'kitkat'
      expect(subject.display).to eq 'INSERT COIN'
      expect(subject.hopper).to be nil
    end
  end
  context 'Make Change' do
    it 'will return excess payment to the customer' do
      subject.insert '25'
      subject.insert '25'
      subject.insert '10'
      subject.insert '10'
      subject.insert '5'
      subject.button 'candy'
      expect(subject.hopper.name).to eq 'candy'
      expect(subject.display).to eq 'THANK YOU'
      expect(subject.display).to eq 'INSERT COIN'
      expect(subject.coin_return).to eq '10'
    end
  end
end
