class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pages = current_user.pages
  end

  def exports
    @users = User.all
    @pages = Page.order('created_at DESC')
      respond_to do |format|
        format.html
        format.xlsx {
          response.headers['Content-Disposition'] = 'attachment; filename="timesheet_export.xlsx"'
        }
      end
  end

  def exportsall
    @users = User.all
    @pages = Page.order('created_at DESC')
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="timesheet_all_export.xlsx"'
      }
    end
  end

  def exportsDepart
    @users = User.all
    @pages = Page.order('created_at DESC')
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="timesheet_by_department.xlsx"'
      }
    end
  end

  def dashboard
    if current_user.admin == false
      @pages = current_user.pages
      @new_pages = Page.new
    else
      @pages = Page.where(:department => current_user.department)
      @new_pages = Page.new
    end
  end

  def create
    @new_pages = Page.new(params_final)
    if @new_pages.save!
      flash[:success] = "Timesheet entry created!"
      redirect_to root_url
    else
      flash[:success] = "Timesheet entry failed :("
      redirect_to root_url
    end
  end

  def destroy
    @page = Page.find params[:id]
    @page.destroy

    respond_to do |format|
      format.html { redirect_to  }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  private
  def params_final
    new_pages_params.merge(:user => current_user)
  end

  def new_pages_params
    params.require(:page).permit(:creditUnion, :activity, :task, :billingOptions, :billingOptionsSCR, :billingOptionsFTR, :sun, :mon, :tue, :wed, :thu, :fri, :sat, :total, :dateOfTime, :department)
  end


end
