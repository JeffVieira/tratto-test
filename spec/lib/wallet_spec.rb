require 'spec_helper'
require 'wallet'

RSpec.describe Wallet, type: :model do

  let(:wallet) { Wallet.new(currency: "USD", amount: 100.0) }

  describe ".withdraw" do
    context "when wallet have the amount" do
      it "should decrease the value" do
        wallet.withdraw(50.0)
        expect(wallet.amount).to eq(50.0)
      end
    end

    context "when wallet doesnt have the amount" do
      it "should return a exception" do
        expect{ wallet.withdraw(150) }.to raise_error "wallet dont have minimun amount"
      end
    end
  end

  describe ".credit" do
    context "when wallet have the same currency" do
      it "should sum the value" do
        wallet.credit(50.0, "USD")
        expect(wallet.amount).to eq(150.0)
      end
    end

    context "when wallet doesnt have same currency" do
      it "should exchange and sum the value" do
        wallet.credit(50.0, "EUR")
        expect(wallet.amount).to eq(150.0)
      end
    end
  end
end
