class FinancialTransactionsController < ApplicationController
  def create
    begin
      file_upload(params[:cnab_file])

      flash.now[:info] = t('notifications.upload.success')
      render :new

    rescue Exception => e
      flash.now[:error] = t('notifications.upload.error')
      render :new
    end
  end

  private

  def file_upload(file)
    File.open(File.join('tmp', 'storage', file.original_filename), 'wb') do |f|
      f.write(file.read)
    end
  end
end
