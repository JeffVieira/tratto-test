require 'sequel'

DB.create_table :clients do
  primary_key :id
  String :name
end

class Client < Sequel::Model
  one_to_many :wallets

  def self.find_or_create(client_name)
    client = Client.find(name: client_name)
    client = Client.create(name: client_name) if client.nil?
    client
  end

end
