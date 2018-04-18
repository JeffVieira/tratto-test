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
end
