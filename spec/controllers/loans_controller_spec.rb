require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "responds with json of loan" do
      Loan.create!(funded_amount: 100.0)
      expected = Loan.all.each.to_json({:methods => :outstanding_balance})
      get :index
      expect(response.body).to eq expected
    end
  end

  describe '#show' do
    it 'responds with a 200' do
      get :show, params: { id: loan.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
