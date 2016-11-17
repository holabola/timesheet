class PagesController < ApplicationController
  before_action :authenticate_user!


  def dashboard
    @new_pages = Page.new
  end

  def create
    @new_pages = Page.new(new_pages_params)
    if @new_pages.save!
      flash[:success] = "Timesheet entry created!"
      redirect_to root_url
    else
      flash[:success] = "Timesheet entry failed :("
      redirect_to root_url
    end
  end

  def destroy
  end

  private

  def new_pages_params
    params.require(:page).permit(:creditUnion)
  end

end
