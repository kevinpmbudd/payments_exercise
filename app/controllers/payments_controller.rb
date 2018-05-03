class PaymentsController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    loan = Loan.find_by_id(params[:loan_id])
    render json: loan.payments
  end

  def show
    payment = Payment.find_by_id(params[:id])
    render json: payment
  end

  def create
    payment = Payment.new(payment_params)
    payment.loan = Loan.find_by_id(params[:loan_id])

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
