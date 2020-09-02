require 'rails_helper'

RSpec.describe ImportCnabDataJob, type: :job do
  before {
    ActiveJob::Base.queue_adapter = :test

    Transaction.destroy_all
    TransactionType.create(id: 1, description: 'Débito', origin: 0)
  }

  describe 'perform later job added to queue' do
    it { expect { ImportCnabDataJob.perform_later('spec/fixtures/files', 'cnab.txt') }.to enqueue_job }
    it { expect { ImportCnabDataJob.perform_later('spec/fixtures/files', 'cnab.txt') }.to have_enqueued_job.on_queue("import").at(:no_wait) }
  end

  describe 'job executed' do
    before {
      ImportCnabDataJob.perform_now('spec/fixtures/files', 'cnab.txt')
    }

    it { expect(Transaction.count).to eql(1) }
    it { expect(Transaction.first).to_not be_nil }
  end
end
