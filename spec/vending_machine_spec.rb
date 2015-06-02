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
    class VendingMachine; attr_reader :coins; end
    expect(subject.coins).to eq []
  end
end


