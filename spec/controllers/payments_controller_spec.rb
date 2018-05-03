require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  describe '#index' do
    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
      it "increases the number of Payments by 1" do
        expect{ post :create, params: { loan_id: loan.id, payment: { amount: 10.0 } } }.to change(Payment,:count).by(1)
      end

      it "should return errors for an invalid payment" do
        post :create, params: { loan_id: loan.id, payment: { amount: 1000.0 } }
        expect(JSON.parse(response.body)).to eq "errors"=>["Amount cannot be greater than the outstanding balance"]
      end
    end
end
