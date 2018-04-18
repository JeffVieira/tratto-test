require 'spec_helper'
require 'client'
require 'wallet'

RSpec.describe Client, type: :model do
  describe ".find_or_create" do
    subject { Client.find_or_create("jeff") }

    context "when user already exist" do
      it "should not create a new user" do
        expect{ subject }.to change{Client.count}.from(0).to(1)
      end
    end

    context "when user dont exist" do
      let!(:client) { Client.create(name:"jeff") }

      it "should create a new user" do
        expect{ subject }.to_not change{Client.count}
      end
    end
  end

  describe ".get_currency_wallet" do
    let!(:client) { Client.create(name: "jeff") }
    let!(:wallet) { Wallet.create(currency: "USD", amount: 50.0, client_id: client.id) }

    context "when client have the Wallet" do
      it "should return a Wallet" do
        expect( Client.get_currency_wallet("jeff", "USD") ).to eq(wallet)
      end
    end

    context "when client doesnt have the Wallet" do
      it "should return Exception" do
        expect { Client.get_currency_wallet("jeff","BRL") }.to raise_error "No wallet whit currency BRL found for jeff"
      end
    end
  end
end
