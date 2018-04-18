require_relative 'db'
require_relative 'csv_parse'
require 'json'

CsvParse.new

class WalletCentral
  def self.transfer(from, to, currency, amount)
    from_wallet = Client.get_currency_wallet(from, currency)
    from_wallet.withdraw(amount)

    to_wallet = Client.get_currency_wallet(to, currency, true)
    to_wallet.credit(amount, currency)
  end

  def self.output(filter = nil)
    begin
      Client.print(filter).to_json
    rescue Exception => e
      puts e
    end
  end
end
