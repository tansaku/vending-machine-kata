require 'vending_machine'

describe VendingMachine do
  context 'valid coins' do
    it 'accepts a nickel and updates display' do
      subject.insert '5'
      expect(subject.display).to eq '5 cents'
    end
    it 'accepts a dime and updates display' do
      subject.insert '10'
      expect(subject.display).to eq '10 cents'
    end
    it 'accepts a quarter and updates display' do
      subject.insert '25'
      expect(subject.display).to eq '25 cents'
    end
    it 'accepts coin combo and updates display' do
      subject.insert '5'
      subject.insert '10'
      subject.insert '25'
      expect(subject.display).to eq '40 cents'
    end
  end
  context 'invalid coins' do
    it 'rejects a penny and updates display' do
      subject.insert '1'
      expect(subject.display).to eq 'INSERT COIN'
      expect(subject.coin_return).to eq '1'
    end
    it 'rejects a non-coin and updates display' do
      subject.insert '113r2qfasc'
      expect(subject.display).to eq 'INSERT COIN'
      expect(subject.coin_return).to eq '113r2qfasc'
    end
  end
  it 'displays INSERT COIN when no coins inserted' do
    expect(subject.display).to eq 'INSERT COIN'
  end
  it { is_expected.to respond_to(:hopper) }
  it 'has buttons to vend products' do
    subject.insert '25'
    subject.insert '25'
    subject.insert '25'
    subject.insert '25'
    subject.button 'cola'
    expect(subject.display).to eq 'THANK YOU'
    expect(subject.display).to eq 'INSERT COIN'
    expect(subject.send(:coins)).to eq []
  end
  it 'will not vend cola without sufficient payment' do
    subject.button 'cola'
    expect(subject.display).to eq 'PRICE 100'
  end
  it 'will not vend chips without sufficient payment' do
    subject.button 'chips'
    expect(subject.display).to eq 'PRICE 50'
  end
  it 'will reset display after insufficient payment' do
    subject.insert '25'
    subject.insert '25'
    subject.button 'cola'
    subject.display
    expect(subject.display).to eq '50 cents'
  end
  it 'will reset display after no payment' do
    subject.button 'cola'
    subject.display
    expect(subject.display).to eq 'INSERT COIN'
  end
  it 'dispense some chips if correct amount is given' do
    subject.insert '25'
    subject.insert '25'
    subject.button 'chips'
    expect(subject.hopper.name).to eq 'chips'
  end
  it 'successful purchase leads to a thankyou' do
    subject.insert '25'
    subject.insert '25'
    subject.button 'chips'
    expect(subject.display).to eq 'THANK YOU'
  end
  it 'selecting invalid product does not update display' do
    subject.button 'kitkat'
    expect(subject.display).to eq 'INSERT COIN'
  end
  it 'selecting invalid product does dispense that product' do
    subject.button 'kitkat'
    expect(subject.hopper).to be nil
  end
  context 'related to Make Change Feature' do
    it 'will dispense product after overpayment' do
      subject.insert '25'
      subject.insert '25'
      subject.insert '10'
      subject.insert '10'
      subject.insert '5'
      subject.button 'candy'
      expect(subject.hopper.name).to eq 'candy'
    end
    it 'will return coins given overpayment' do
      subject.insert '25'
      subject.insert '25'
      subject.insert '10'
      subject.insert '10'
      subject.insert '5'
      subject.button 'candy'
      expect(subject.coin_return).to eq '10'
    end
  end
end
