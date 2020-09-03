class FinancialTransactionsController < ApplicationController
  def create
    begin
      file = FinancialTransactionsHelper.upload(params[:cnab_file])

      ImportCnabDataJob.perform_now('tmp/storage', params[:cnab_file].original_filename)

      flash.now[:info] = t('notifications.upload.success')
      render :new

    rescue Exception => e
      flash.now[:error] = t('notifications.upload.error')
      render :new
    end
  end
end
