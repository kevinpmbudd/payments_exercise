class LoansController < ApplicationController
  def index
    render json: Loan.all.to_json({:methods => :outstanding_balance})
  end

  def show
    render json: Loan.find(params[:id]).to_json({:methods => :outstanding_balance})
  end
end
