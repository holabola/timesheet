class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pages = current_user.pages
  end

  #Expense

  def document_params
    params.require(:document).permit(:file)
  end

  def expenses
    @expenses = current_user.expenses.order('dateActivity DESC')
    @new_expenses = Expense.new

  end



  #Exports

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

  #dashboard

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
    #Timesheet
    current_uri = request.env['PATH_INFO']
    if current_uri == "/pages"
    @new_pages = Page.new(params_final)
    if @new_pages.save!
      flash[:success] = "Timesheet entry created!"
      redirect_to root_url
    else
      flash[:success] = "Timesheet entry failed :("
      redirect_to root_url
    end
    end

    #Expense
    if current_uri == "/expenses"
      @new_expenses = Expense.new(params_final_expense)
      if @new_expenses.save
        flash[:success] = "Expense entry created!"

        redirect_to expenses_url
      else
        flash[:success] = "Expense entry failed :("
        redirect_to expenses_url
      end
    end
  end

  def destroy
    current_type = params[:type]

    if current_type == "timesheet"
      @page = Page.find params[:id]
      @page.destroy

      respond_to do |format|
        format.html { redirect_to  }
        format.json { head :no_content }
        format.js   { render :layout => false }
      end
    end

    if current_type == "expense"
      @expense = Expense.find params[:id]
      @expense.destroy

      respond_to do |format|
        format.html { redirect_to  }
        format.json { head :no_content }
        format.js   { render :template => 'destroyExpense.js.erb', :layout => false }
      end
    end

  end

  def update
    @page = Page.find(params[:id])
    @approvalStatus = params[:subaction]

    respond_to do |format|
      if @page.update_attributes(:approval => @approvalStatus)
        # If update succeeds, redirect to the list action
        format.js   { }
        format.json { render :show, status: :created, location: @comment }


      else
        # If save fails, redisplay the form so user can fix problems
        format.js   { }
        flash[:notice] = "Approval failed."
      end
     end
  end

  #approvals

  def approvals
    @pages = Page.where(:department => current_user.department).order('dateOfTime ASC')
    @new_pages = Page.new
  end

  private
  def params_final
    new_pages_params.merge(:user => current_user)
  end

  def update_params
    params.require(:page).permit(:approval)
  end

  def new_pages_params
    params.require(:page).permit(:creditUnion, :activity, :task, :billingOptions, :billingOptionsSCR, :billingOptionsFTR, :sun, :mon, :tue, :wed, :thu, :fri, :sat, :total, :dateOfTime, :department)
  end

  def params_final_expense
    new_pages_params_expense.merge(:user => current_user)
  end

  def new_pages_params_expense
    params.require(:expense).permit(:dateActivity, :typeOfExpense, :amount, :payment, :notes, :image)
  end




end
