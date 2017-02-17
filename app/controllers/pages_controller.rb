class PagesController < ApplicationController
  before_action :authenticate_user!
  before_filter :authorize_admin, only: [:approvals, :exports, :expensesapprovals]

  def index
    @pages = current_user.pages
  end

  #Expense

  def document_params
    params.require(:document).permit(:file)
  end

  def expenses
    @expenses = current_user.expenses.order('date_activity DESC')
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

  def exportsExpenses
    @users = User.all
    @expenses = Expense.order('created_at DESC')
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="expenses_by_department.xlsx"'
      }
    end
  end

  #dashboard

  def dashboard
    if current_user.admin == false
      @pages = current_user.pages
      @new_pages = Page.new
    else
      @pages = current_user.pages #Page.where(:department => current_user.department)
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
      @new_expenses.department = current_user.department
      if @new_expenses.save
        flash[:success] = "Expense entry created!"

        redirect_to expenses_url
      else
        flash[:error] = @new_expenses.errors.full_messages.to_sentence
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

    @approvalStatus = params[:subaction]
    if @approvalStatus == "Approved" || @approvalStatus == "Unapproved"
      datez = Page.find(params[:id]).date_of_time
      dateblob = datez.to_date
      firstdate = dateblob.beginning_of_week - 1.day
      lastdate = firstdate + 7.day
      @departmentblob = Page.find(params[:id]).department
      @pagez = Page.where(["date_of_time IN (?)",
                                        (firstdate)..(lastdate)]).where(:user_id => Page.find(params[:id]).user_id)

      #Client.all(:conditions => ["created_at > ? AND created_at < ?", params[:start_date], params[:end_date]])
      print "\n#####\n"
      print Page.find(params[:id]).user_id
      print "\n#####\n"
      print
      print "\n#####\n"


      respond_to do |format|
        if @pagez.update_all(:approval => @approvalStatus)
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

    if @approvalStatus == "ApprovedEX" || @approvalStatus == "UnapprovedEX"
      @expense = Expense.find(params[:id])
      if @approvalStatus == "ApprovedEX"
        @approvalStatus = "Approved"
      end
      if @approvalStatus == "UnapprovedEX"
        @approvalStatus = "Unapproved"
      end


      respond_to do |format|
        if @expense.update_attributes(:approval => @approvalStatus)
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
  end

  #approvals

  def approvals
    @pages = Page.where(:department => current_user.department).order('date_of_time DESC')
    @new_pages = Page.new
  end


  def expensesapprovals
    @expenses = Expense.where(:department => current_user.department).order('date_activity DESC')
    @new_expenses = Expense.new
  end

  private
  def authorize_admin
    redirect_to :back, status: 401 unless current_user.admin
  rescue ActionController::RedirectBackError
    redirect_to root_path
    flash[:notice] = "You cannot access this page :("
    #redirects to previous page
  end

  def params_final
    new_pages_params.merge(:user => current_user)
  end

  def update_params
    params.require(:page).permit(:approval)
  end

  def new_pages_params
    params.require(:page).permit(:credit_union, :activity, :task, :billing_options, :sun, :mon, :tue, :wed, :thu, :fri, :sat, :total, :date_of_time, :department, :sunnotes, :monnotes, :tuenotes, :wednotes, :thunotes, :frinotes, :satnotes)
  end

  def params_final_expense
    new_pages_params_expense.merge(:user => current_user)
  end

  def new_pages_params_expense
    params.require(:expense).permit(:date_activity, :type_of_expense, :amount, :payment, :notes, :image)
  end




end
