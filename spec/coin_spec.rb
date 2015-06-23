require 'coin'

describe Coin do

  let(:penny) { Coin::PENNY }
  let(:nickel) { Coin::NICKEL }
  let(:dime) { Coin::DIME }
  let(:quarter) { Coin::QUARTER }

  it 'penny to have value of 1' do
    expect(penny.value).to eq 1
  end

  it 'nickel to have value of 5' do
    expect(nickel.value).to eq 5
  end

  it 'dime to have value of 10' do
    expect(dime.value).to eq 10
  end

  it 'quarter to have value of 25' do
    expect(quarter.value).to eq 25
  end

end
