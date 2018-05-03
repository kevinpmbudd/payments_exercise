require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  it { should have_many(:payments) }

  context 'no payments have been made to a loan' do
    describe '#outstanding_balance' do
      it 'should equal funded_amount' do
        expect(loan.outstanding_balance).to eq loan.funded_amount
      end
    end
  end

  context 'payments have been made to a loan' do
    describe '#outstanding_balance' do
      it 'should update 1 payment' do
        Payment.create!(amount: 10.0, loan_id: loan.id)
        expect(loan.outstanding_balance).to eq 90
      end

      it 'should stay up to date with valid payments' do
        Payment.create!(amount: 10.0, loan_id: loan.id)
        Payment.create!(amount: 80.0, loan_id: loan.id)
        expect(loan.outstanding_balance).to eq 10
      end

      it 'should not change after invalid payments are attempted' do
        Payment.create(amount: 1000.0, loan_id: loan.id)
        expect(loan.outstanding_balance).to eq loan.funded_amount
      end
    end
  end
end
