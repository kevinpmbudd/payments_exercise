class PaymentsController < ApplicationController
  def index
    loan = Loan.find(params[:loan_id])
    render json: loan.payments
  end

  def show
    payment = Payment.find(params[:id])
    render json: payment
  end

  def create
    loan = Loan.find(params[:loan_id])
    payment = Payment.new(payment_params)
    payment.loan = loan 

    if payment.save
      render json: payment
    else
      render json: { errors: payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount)
  end
end
