require 'rails_helper'

RSpec.describe FinancialTransactionsController, type: :controller do
  describe 'GET new' do
    it 'returns a 200' do
      get :new

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    it 'returns a 200 without error' do
      post :create, params: { cnab_file: fixture_file_upload('files/cnab.txt') }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)

      should set_flash.now[:info].to(I18n.t('notifications.upload.success'))
    end

    it 'returns a 200 with error' do
      post :create

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)

      should set_flash.now[:error].to(I18n.t('notifications.upload.error'))
    end
  end
end