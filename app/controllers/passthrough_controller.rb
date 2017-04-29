class PassthroughController < ApplicationController
  def index
    if current_user.nil?

    end
    if current_user.admin?
      redirect_to '/admin'
    else
      redirect_to '/timesheet'
    end

  end


end
