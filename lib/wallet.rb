require 'sequel'

DB.create_table :wallets do
  primary_key :id
  Integer :client_id
  String :currency
  Float :amount
end

class Wallet < Sequel::Model
  many_to_one :client
end
