require 'rails_helper'

RSpec.describe FinancialTransactionsHelper, type: :helper do
  describe 'should upload file' do
    let(:file) { fixture_file_upload('files/cnab.txt') }

    it { expect(FinancialTransactionsHelper.upload(file)).to_not be_nil }
    it { expect(FinancialTransactionsHelper.upload(file).class).to eql(Rack::Test::UploadedFile) }
  end

  describe 'read CNAB file to extract data and send transaction to be saved' do
    before {
      Transaction.destroy_all
      TransactionType.create(id: 1, description: 'Débito', origin: 0)

      FinancialTransactionsHelper.read_file_to_save_data('spec/fixtures/files', 'cnab.txt')
    }

    it { expect(Transaction.first).to_not be_nil }
  end

  describe 'save the dependencies and transaction' do
    let(:amount) { 999.98 }
    let(:cpf) { '84515254073' }
    let(:card) { '6777****1313' }
    let(:occurred_in) { DateTime.now.utc }
    let(:store_owner) { 'MARCOS PEREIRA' }
    let(:store_name) { 'MERCADO DA AVENIDA' }
    let(:transaction_type) { TransactionType.create(description: 'Débito', origin: 0) }

    let(:transaction) { 
      { 
        cpf: cpf,
        card: card,
        amount: amount,
        store_name: store_name,
        store_owner: store_owner,
        occurred_in: occurred_in,
        type: transaction_type.id
      }
    }

    before { 
      Transaction.destroy_all
      FinancialTransactionsHelper.save(transaction)
    }

    it { expect(Transaction.first).to_not be_nil }
    it { expect(Transaction.first.amount).to eql(amount) }
    it { expect(Transaction.first.occurred_in).to eql(occurred_in) }

    it { expect(Transaction.first.store.name).to eql(store_name) }
    it { expect(Transaction.first.store.owner).to eql(store_owner) }
    
    it { expect(Transaction.first.recipient.cpf).to eql(cpf) }
    it { expect(Transaction.first.recipient.card).to eql(card) }
    
    it { expect(Transaction.first.transaction_type).to eql(transaction_type) }
  end

  describe 'split line with data matched' do
    let(:line) { '3201903010000019200845152540736777****1313172712MARCOS PEREIRAMERCADO DA AVENIDA' }

    it { expect(FinancialTransactionsHelper.split(line)[:type]).to eql('3') }
    it { expect(FinancialTransactionsHelper.split(line)[:time]).to eql('172712') }
    it { expect(FinancialTransactionsHelper.split(line)[:date]).to eql('20190301') }
    it { expect(FinancialTransactionsHelper.split(line)[:cpf]).to eql('84515254073') }
    it { expect(FinancialTransactionsHelper.split(line)[:card]).to eql('6777****1313') }
    it { expect(FinancialTransactionsHelper.split(line)[:amount]).to eql('0000019200') }
    it { expect(FinancialTransactionsHelper.split(line)[:store]).to eql('MARCOS PEREIRAMERCADO DA AVENIDA') }
  end

  describe 'extract store name from string with owner name and store name' do
    it { expect(FinancialTransactionsHelper.extract_store('JOÃO MACEDO   BAR DO JOÃO       ')).to eql('BAR DO JOÃO')}
    it { expect(FinancialTransactionsHelper.extract_store('JOSÉ COSTA    MERCEARIA 3 IRMÃOS')).to eql('MERCEARIA 3 IRMÃOS')}
    it { expect(FinancialTransactionsHelper.extract_store('MARCOS PEREIRAMERCADO DA AVENIDA')).to eql('MERCADO DA AVENIDA')}
    it { expect(FinancialTransactionsHelper.extract_store('MARIA JOSEFINALOJA DO Ó - FILIAL')).to eql('LOJA DO Ó - FILIAL')}
  end

  describe 'extract owner name from string with owner name and store name' do
    it { expect(FinancialTransactionsHelper.extract_owner('JOSÉ COSTA    MERCEARIA 3 IRMÃOS')).to eql('JOSÉ COSTA')}
    it { expect(FinancialTransactionsHelper.extract_owner('JOÃO MACEDO   BAR DO JOÃO       ')).to eql('JOÃO MACEDO')}
    it { expect(FinancialTransactionsHelper.extract_owner('MARCOS PEREIRAMERCADO DA AVENIDA')).to eql('MARCOS PEREIRA')}
    it { expect(FinancialTransactionsHelper.extract_owner('MARIA JOSEFINALOJA DO Ó - FILIAL')).to eql('MARIA JOSEFINA')}
  end

  describe 'parse value as currency' do
    it { expect(FinancialTransactionsHelper.parse_to_currency(0)).to eq(0.00) }
    it { expect(FinancialTransactionsHelper.parse_to_currency('0')).to eq(0.00) }

    it { expect(FinancialTransactionsHelper.parse_to_currency(123456)).to eq(1234.56) }
    it { expect(FinancialTransactionsHelper.parse_to_currency('123456')).to eq(1234.56) }

    it { expect(FinancialTransactionsHelper.parse_to_currency(123400)).to eq(1234.00) }
    it { expect(FinancialTransactionsHelper.parse_to_currency('123400')).to eq(1234.00) }
  end

  describe 'parse date and time as datetime' do
    it { expect(FinancialTransactionsHelper.parse_to_datetime('20190301', '172712').day).to eq(1) }
    it { expect(FinancialTransactionsHelper.parse_to_datetime('20190301', '172712').month).to eq(3) }
    it { expect(FinancialTransactionsHelper.parse_to_datetime('20190301', '172712').year).to eq(2019) }

    it { expect(FinancialTransactionsHelper.parse_to_datetime('20190301', '172712').hour).to eq(17) }
    it { expect(FinancialTransactionsHelper.parse_to_datetime('20190301', '172712').minute).to eq(27) }
    it { expect(FinancialTransactionsHelper.parse_to_datetime('20190301', '172712').second).to eq(12) }

    it { expect(FinancialTransactionsHelper.parse_to_datetime('20190301', '172712').class).to eq(DateTime) }

    it { expect(FinancialTransactionsHelper.parse_to_datetime('20190301', '172712')).to eq('Fri, 01 Mar 2019 17:27:12 +0000') }
  end
end
