class Wallet < Sequel::Model
  many_to_one :client
end
