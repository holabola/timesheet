class Expense < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ExpenseUploader


  after_initialize :default_value
  def default_value
    self.approval = 'Pending' if self.approval.nil?
  end

end