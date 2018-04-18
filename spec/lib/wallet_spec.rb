require 'spec_helper'
require 'wallet'

RSpec.describe Wallet, type: :model do

  let(:wallet) { Wallet.new(currency: "USD", amount: 100.0) }

  describe ".withdraw" do
    context "when wallet have the amount" do
      it "should decrease the value" do
      end
    end

    context "when wallet doesnt have the amount" do
      it "should return a exception" do
      end
    end
  end

  describe ".credit" do
    context "when wallet have the same currency" do
      it "should sum the value" do
      end
    end

    context "when wallet doesnt have same currency" do
      it "should exchange and sum the value" do
      end
    end
  end
end
