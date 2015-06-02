require 'vending_machine'

describe VendingMachine do
  it 'accepts coins and updates display' do
    subject.insert '5'
    expect(subject.display).to eq '5 cents'
  end
end