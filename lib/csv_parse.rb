require_relative 'client'
require_relative 'wallet'
require 'roo'

class CsvParse
  def initialize
    load
  end

  private
    def load
      file_exist?
      spreadsheet = Roo::Spreadsheet.open(file_path, extension: :csv)
      spreadsheet.each_with_index(import_map) do |subject, i|
        unless i == 0
          client = Client.find_or_create(subject[:client])
          Wallet.create(currency: subject[:currency], amount: subject[:amount], client_id: client.id)
        end
      end
    end

    def import_map
      {
        client: 'Client',
        currency: 'Currency',
        amount: 'Amount'
      }
    end

    def file_path
      return 'lib/resources/wallets.csv'
    end

    def file_exist?
      return if File.exists?(file_path)
      raise Exception.new("No file found")
    end
end
