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

  describe ".print" do
    let!(:client) { Client.create(name: "jeff") }
    let!(:wallet) { Wallet.create(currency: "USD", amount: 50.0, client_id: client.id) }

    context "when have filter" do
      it "should return one client" do
        expect(Client.print("jeff") ).to eq({:name=>"jeff", :wallets=>{"USD"=>50.0}})
      end
    end

    context "when dont have filter" do
      let!(:client2) { Client.create(name: "j4") }
      let!(:wallet2) { Wallet.create(currency: "BRL", amount: 150.0, client_id: client2.id) }

      it "should return all clients" do
        expect(Client.print(nil) ).to eq([{:name=>"jeff", :wallets=>{"USD"=>50.0}},
                                         {:name=>"j4", :wallets=>{"BRL"=>150.0}}])
      end
    end
  end

  describe ".get_client" do
    context "when user exist" do
      let!(:client) { Client.create(name: "jeff") }

      it "should return a user" do
        expect(Client.get_client("jeff") ).to eq(client)
      end
    end

    context "when user dont exist" do
      it "should return Exception" do
        expect { Client.get_client("jeff") }.to raise_error "No client jeff found"
      end
    end
  end
end
