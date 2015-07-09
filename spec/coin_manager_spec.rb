require 'coin_manager'

describe CoinManager do

  it 'has zero total by default' do
    expect(subject.total).to eq 0
  end

  context 'valid coins' do
    it 'accepts a nickel and updates total' do
      subject.insert Coin::NICKEL
      expect(subject.total).to eq 5
    end
    it 'accepts a dime and updates total' do
      subject.insert Coin::DIME
      expect(subject.total).to eq 10
    end
    it 'accepts a quarter and updates total' do
      subject.insert Coin::QUARTER
      expect(subject.total).to eq 25
    end
    it 'accepts coin combo and updates total' do
      subject.insert Coin::NICKEL
      subject.insert Coin::DIME
      subject.insert Coin::QUARTER
      expect(subject.total).to eq 40
    end
  end

  context 'invalid coins' do
    it 'rejects a penny and does not update total' do
      subject.insert Coin::PENNY
      expect(subject.total).to eq 0
    end
    it 'rejects a non-coin and does not update total' do
      subject.insert '113r2qfasc'
      expect(subject.total).to eq 0
    end
  end

  describe '#make_change' do
    it 'return dime given overpayment' do
      2.times { subject.insert Coin::QUARTER }
      2.times { subject.insert Coin::DIME }
      subject.insert Coin::NICKEL
      subject.make_change 65
      expect(subject.coin_return).to eq Coin::DIME
    end
    it 'return quarter given overpayment' do
      3.times { subject.insert Coin::QUARTER }
      subject.insert Coin::DIME
      subject.insert Coin::NICKEL
      subject.make_change 65
      expect(subject.coin_return).to eq Coin::QUARTER
    end
    xit 'manage multiple coin overpayment'
    xit 'manage coins in ascending order'
  end
end
