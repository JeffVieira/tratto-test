class Client < Sequel::Model
  one_to_many :wallets

  def self.find_or_create(client_name)
    client = Client.find(name: client_name)
    client = Client.create(name: client_name) if client.nil?
    client
  end

  def self.get_currency_wallet(client_name, currency, return_first = false)
    client = Client.find(name: client_name)
    raise Exception.new("No client #{client_name} found") if client.nil?

    wallet = client.wallets.find{|w| w.currency == currency}
    raise Exception.new("No wallet whit currency #{currency} found for #{client_name}") if wallet.nil? && !return_first
    wallet = client.wallets.first if wallet.nil? && return_first
    wallet
  end

  def self.print(filter)
    if filter.nil?
      Client.all.map do |client|
        { name: client.name, wallets: client.wallets.map{|w| [w.currency, w.amount]}.to_h }
      end
    else
      client = Client.find(name: filter)
      raise Exception.new("No client #{filter} found") if client.nil?
      { name: client.name, wallets: client.wallets.map{|w| [w.currency, w.amount]}.to_h }
    end
  end

end
