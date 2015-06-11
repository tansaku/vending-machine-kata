require 'coin_manager'

describe CoinManager do
  it 'has zero total by default' do
    expect(subject.total).to eq 0
  end
  context 'valid coins' do
    it 'accepts a nickel and updates total' do
      subject.insert '5'
      expect(subject.total).to eq 5
    end
    it 'accepts a dime and updates total' do
      subject.insert '10'
      expect(subject.total).to eq 10
    end
    it 'accepts a quarter and updates total' do
      subject.insert '25'
      expect(subject.total).to eq 25
    end
    it 'accepts coin combo and updates total' do
      subject.insert '5'
      subject.insert '10'
      subject.insert '25'
      expect(subject.total).to eq 40
    end
  end
  context 'invalid coins' do
    it 'rejects a penny and updates total' do
      subject.insert '1'
      expect(subject.total).to eq 0
    end
    it 'rejects a non-coin and updates total' do
      subject.insert '113r2qfasc'
      expect(subject.total).to eq 0
    end
  end
  describe '#make_change' do
    it 'return coins given overpayment' do
      subject.insert '25'
      subject.insert '25'
      subject.insert '10'
      subject.insert '10'
      subject.insert '5'
      subject.make_change 65
      expect(subject.coin_return).to eq '10'
    end
    it 'return coins given overpayment' do
      subject.insert '25'
      subject.insert '25'
      subject.insert '25'
      subject.insert '10'
      subject.insert '5'
      subject.make_change 65
      expect(subject.coin_return).to eq '25'
    end
    xit 'manage multiple coin overpayment'
  end
end
