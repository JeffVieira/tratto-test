require 'sequel'

DB = Sequel.sqlite

DB.create_table :clients do
  primary_key :id
  String :name
end

DB.create_table :wallets do
  primary_key :id
  Integer :client_id
  String :currency
  Float :amount
end
