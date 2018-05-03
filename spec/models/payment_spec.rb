require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  it { should belong_to(:loan) }

  it { should validate_numericality_of(:amount) }

  describe "amount_validation" do
    it "should allow payments less than the outstanding balance" do
      Payment.create!(amount: 10.0, loan_id: loan.id)
      expect(loan.payments.count).to eq 1
    end

    it "should not allow payments greater than the outstanding balance" do
      payment = Payment.create(amount: 1000.0, loan_id: loan.id)
      expect(loan.payments.count).to eq 0
    end
  end
end
