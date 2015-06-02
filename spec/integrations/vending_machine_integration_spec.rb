require 'vending_machine'

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
end