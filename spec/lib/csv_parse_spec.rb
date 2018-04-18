require 'spec_helper'
require 'csv_parse'

RSpec.describe CsvParse, type: :model do

  describe ".load" do
    let(:parser) {CsvParse.new}

    context "when file is not found" do
      it "should raise a error" do
        allow_any_instance_of(CsvParse).to receive(:file_path).and_return('spec/lib/resources/not_found.csv')
        expect{ parser }.to  raise_error "No file found"
      end
    end

    context "when file is found" do
      it "should create Clients" do
        parser
        expect(Client.count).to eq(11)
      end

      it "should create Wallets" do
        parser
        expect(Wallet.count).to eq(20)
      end
    end
  end
end
