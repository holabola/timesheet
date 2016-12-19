class Expense < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  #before_validation {write_attribute(:dateActivity, Date.strptime(@dateActivity, "%m/%d/%Y")) }

  after_initialize :default_value
  def default_value
    self.approval = 'Pending' if self.approval.nil?
  end

end
