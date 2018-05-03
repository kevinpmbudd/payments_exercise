class Payment < ApplicationRecord
  after_initialize do |payment|
    payment.date ||= Date.today if new_record?
  end

  belongs_to :loan
  validates :loan, presence: true

  validates :amount, numericality: { greater_than: 0 }
  validate  :amount_validation

  validate  :date_is_not_in_past

  def amount_validation
    return unless amount && loan
    if amount > loan.outstanding_balance
      errors.add(:amount, "cannot be greater than the outstanding balance")
    end
  end

  def date_is_not_in_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
