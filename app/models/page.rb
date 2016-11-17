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


end
