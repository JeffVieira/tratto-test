class Client < Sequel::Model
  one_to_many :wallets

  def self.find_or_create(client_name)
    client = Client.find(name: client_name)
    client = Client.create(name: client_name) if client.nil?
    client
  end

  def self.get_currency_wallet(client_name, currency, return_first = false)
    client = get_client(client_name)

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
      client = get_client(filter)
      { name: client.name, wallets: client.wallets.map{|w| [w.currency, w.amount]}.to_h }
    end
  end

  private
    def self.get_client(name)
      client = Client.find(name: name)
      raise Exception.new("No client #{name} found") if client.nil?
      client
    end

end
