class Expense < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ExpenseUploader
  validates :credit_union, presence: true
  validates :type_of_expense, presence: true
  validates :amount, presence: true


  before_create :default_value
  def default_value
    self.approval = 'Pending' if self.approval.nil?
    self.approvalFinal = 'Pending' if self.approvalFinal.nil?
  end


end
