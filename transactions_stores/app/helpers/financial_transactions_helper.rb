module FinancialTransactionsHelper
  STORE_SIZE = 18
  OWNER_SIZE = 14
  DIVISOR_CURRENCY = 100.00

  def self.upload(file)
    File.open(File.join('tmp', 'storage', file.original_filename), 'wb') do |f|
      f.write(file.read)
    end

    file
  end

  def self.read_file_to_save_data(path, filename)
    File.open(File.join(path, filename), 'r').each_line do |line| 
      data = split(line)

      save({ cpf: data[:cpf],
             type: data[:type],
             card: data[:card],
             store_name: extract_store(data[:store]),
             store_owner: extract_owner(data[:store]),
             amount: parse_to_currency(data[:amount]),
             occurred_in: parse_to_datetime(data[:date], data[:time]) })
    end
  end

  def self.save(transaction)
    transaction_type = TransactionType.find(transaction[:type])

    recipient = Recipient.find_or_create_by(cpf: transaction[:cpf], 
                                            card: transaction[:card])
    
    store = Store.find_or_create_by(name: transaction[:store_name], 
                                    owner: transaction[:store_owner])

    transaction = Transaction.create(store: store,
                                     recipient: recipient,
                                     amount: transaction[:amount],
                                     transaction_type: transaction_type,
                                     occurred_in: transaction[:occurred_in])
  end

  def self.split(line)
    /(?<type>.)(?<date>........)(?<amount>..........)(?<cpf>...........)(?<card>............)(?<time>......)(?<store>.*)/.match(line)
  end

  def self.extract_store(names)
    names.last(STORE_SIZE).squish
  end

  def self.extract_owner(names)
    names.first(OWNER_SIZE).squish
  end

  def self.parse_to_currency(amount)
    amount.to_d / DIVISOR_CURRENCY
  end

  def self.parse_to_datetime(date, time)
    DateTime.parse("#{date}#{time}")
  end
end
