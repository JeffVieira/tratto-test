class Wallet < Sequel::Model
  many_to_one :client

  def withdraw(withdraw_amount)
    raise Exception.new("wallet dont have minimun amount") if self.amount < withdraw_amount
    self.amount -= withdraw_amount
    self.save
  end

  def credit(credit_amount, credit_currency)
    self.amount += credit_amount
    self.save
  end

  private
    def exchange_amount(amount, from_currency, to_currency)
    end
end
