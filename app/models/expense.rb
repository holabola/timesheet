class Expense < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  #before_validation {write_attribute(:dateActivity, Date.strptime(@dateActivity, "%m/%d/%Y")) }


end
