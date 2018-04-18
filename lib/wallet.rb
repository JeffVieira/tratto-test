class Wallet < Sequel::Model
  many_to_one :client

  def withdraw(withdraw_amount)
    raise Exception.new("wallet dont have minimun amount") if self.amount < withdraw_amount
    self.amount -= withdraw_amount
    self.save
  end

  def credit(credit_amount, credit_currency)
    self.amount += exchange_amount(credit_amount, credit_currency, currency)
    self.save
  end

  private
    def exchange_amount(amount, from_currency, to_currency)
      return amount if from_currency == to_currency
      case [from_currency, to_currency]
      when ["USD", "EUR"]
        value = amount * 0.8
      when ["USD", "BRL"]
        value = amount * 3.16
      when ["EUR", "USD"]
        value = amount / 0.8
      when ["EUR", "BRL"]
        value = (amount / 0.8) * 3.16
      when ["BRL", "USD"]
        value = amount / 3.16
      when ["BRL", "EUR"]
        value = (amount / 3.16) * 0.8
      end
      return value.round(2)
    end
end
