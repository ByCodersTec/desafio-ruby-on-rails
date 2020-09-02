class ImportCnabDataJob < ApplicationJob
  queue_as :import

  def perform(path, filename)
    ActiveRecord::Base.transaction do
      FinancialTransactionsHelper.read_file_to_save_data(path, filename)
    end
  end
end
