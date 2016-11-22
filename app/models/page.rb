class Page < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :sun, presence: true, length: { maximum: 3 }
  validates :mon, presence: true, length: { maximum: 3 }
  validates :tue, presence: true, length: { maximum: 3 }
  validates :wed, presence: true, length: { maximum: 3 }
  validates :thu, presence: true, length: { maximum: 3 }
  validates :fri, presence: true, length: { maximum: 3 }
  validates :sat, presence: true, length: { maximum: 3 }

  after_initialize :default_values
  def default_values
    self.sun = '0' if self.sun.nil?
    self.mon = '0' if self.mon.nil?
    self.tue = '0' if self.tue.nil?
    self.wed = '0' if self.wed.nil?
    self.thu = '0' if self.thu.nil?
    self.fri = '0' if self.fri.nil?
    self.sat = '0' if self.sat.nil?
  end


end
