class Expense < ActiveRecord::Base
  belongs_to :user
  mount_uploaders :images, ExpenseUploader
  serialize :meals
  serialize :meal_names

  validates :credit_union, presence: true
  validates :date_activity, presence: true
  validates :job, presence: true


  before_create :default_value
  def default_value
    self.approval = 'Pending' if self.approval.nil?
    self.submitted = 'Not Submitted' if self.submitted.nil?
    self.approval_final = 'Pending' if self.approval_final.nil?
    self.miles_traveled = '' if self.miles_traveled == 0
    self.mileage_expense = '' if self.mileage_expense == 0
    self.air_travel = '' if self.air_travel == 0
    self.taxi_parking = '' if self.taxi_parking == 0
    self.car_rental = '' if self.car_rental == 0
    self.meals = '' if self.meals == 0
    self.lodging = '' if self.lodging == 0
    self.entertainment = '' if self.entertainment == 0
    self.other = '' if self.other == 0

  end


end
