class PagesController < ApplicationController
  before_action :authenticate_user!
  before_filter :authorize_admin, only: [:approvals, :exports, :expensesapprovals]
  before_filter :set_admin

  def set_admin
    @users_for_switch = User.where(:department => current_user.department)
  end

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

    @CUArray = current_user.pages.pluck(:credit_union).uniq
    @ExtraCUs = current_user.expenses.pluck(:credit_union).uniq
    @temp = @CUArray + @ExtraCUs
    @combinedCUs = (@temp - (@CUArray & @ExtraCUs))

    (@CUArray & @ExtraCUs).each { |x|  @combinedCUs.push(x) }

    @pages = current_user.pages.order('date_of_time DESC')

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
    startDate = Date.strptime(params[:startDate], '%Y-%m-%d')
    endDate = Date.strptime(params[:endDate], '%Y-%m-%d')
    @users = User.where(:department => current_user.department)
    @pages = Page.where(:date_of_time => startDate..endDate).order('date_of_time DESC')
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="timesheet_all_export.xlsx"'
      }
    end
  end

  def exportsDepart
    startDate = Date.strptime(params[:startDate], '%Y-%m-%d')
    endDate = Date.strptime(params[:endDate], '%Y-%m-%d')
    @users = User.where(:department => current_user.department)
    @pages = Page.where(:date_of_time => startDate..endDate).order('date_of_time DESC')
    #@pages = Page.order('created_at DESC')
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Timesheets.xlsx"'
      }
    end
  end

  def exportsExpenses
    startDate = Date.strptime(params[:startDate], '%Y-%m-%d')
    endDate = Date.strptime(params[:endDate], '%Y-%m-%d')
    @users = User.where(:department => current_user.department)
    @expenses = Expense.where(:date_activity => startDate..endDate).order('date_activity DESC')
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Expenses By Department.xlsx"'
      }
    end
  end

  def exportsBillable
    startDate = Date.strptime(params[:startDate], '%Y-%m-%d')
    endDate = Date.strptime(params[:endDate], '%Y-%m-%d')
    @users = User.where(:department => current_user.department)
    @pages = Page.where(:date_of_time => startDate..endDate)
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Billable Hours.xlsx"'
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
      #print Page.find(params[:id]).user_id

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

    ## EXPENSES APPROVAL

    if @approvalStatus == "ApprovedEX" || @approvalStatus == "UnapprovedEX"
      @expense = Expense.find(params[:id])
      if @approvalStatus == "ApprovedEX"
        @approvalStatus = "Approved"
      end
      if @approvalStatus == "UnapprovedEX"
        @approvalStatus = "Unapproved"
      end

      ## NOT USING THIS YET ONLY UPDATES INVIDIVIDUALLY
      datez = Expense.find(params[:id]).date_activity
      dateblob = datez.to_date
      firstdate = dateblob.beginning_of_week - 1.day
      lastdate = firstdate + 7.day
      @departmentblob = Expense.find(params[:id]).department
      @pagez = Expense.where(["date_activity IN (?)",
                           (firstdate)..(lastdate)]).where(:user_id => Expense.find(params[:id]).user_id)


      respond_to do |format|
        if @expense.update(:approval => @approvalStatus)
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

    ##### EXPENSES UPDATE #####

    if @approvalStatus == "Submitted" || @approvalStatus == "Not Submitted"
      datez = Page.find(params[:id]).date_of_time
      dateblob = datez.to_date
      firstdate = dateblob.beginning_of_week - 1.day
      lastdate = firstdate + 7.day
      @departmentblob = Page.find(params[:id]).department
      @pagez = Page.where(["date_of_time IN (?)",
                           (firstdate)..(lastdate)]).where(:user_id => Page.find(params[:id]).user_id)

      #Client.all(:conditions => ["created_at > ? AND created_at < ?", params[:start_date], params[:end_date]])
      #print Page.find(params[:id]).user_id

      respond_to do |format|
        if @pagez.update_all(:submitted => @approvalStatus)
          # If update succeeds, redirect to the list action
          format.html { redirect_to root_path }
          if @approvalStatus == "Submitted"
            flash[:notice] = "Timesheet Submitted"
          end
          if @approvalStatus == "Not Submitted"
            flash[:notice] = "Timesheet Unsubmitted"
          end
        else
          # If save fails, redisplay the form so user can fix problems
          format.html { redirect_to root_path }
          flash[:notice] = "Approval failed."
        end
      end
    end

    if @approvalStatus == "SubmittedEX" || @approvalStatus == "Not SubmittedEX"
      if @approvalStatus == "SubmittedEX"
        @approvalStatus = "Submitted"
      end
      if @approvalStatus == "Not SubmittedEX"
        @approvalStatus = "Not Submitted"
      end

      datez = Expense.find(params[:id]).date_activity
      dateblob = datez.to_date
      firstdate = dateblob.beginning_of_week - 1.day
      lastdate = firstdate + 7.day
      @departmentblob = Expense.find(params[:id]).department
      @pagez = Expense.where(["date_activity IN (?)",
                           (firstdate)..(lastdate)]).where(:user_id => Expense.find(params[:id]).user_id)


      respond_to do |format|
        if @pagez.update_all(:submitted => @approvalStatus)
          # If update succeeds, redirect to the list action
          format.html { redirect_to "/expenses" }
          if @approvalStatus == "Submitted"
            flash[:notice] = "Expenses Submitted"
          end
          if @approvalStatus == "Not Submitted"
            flash[:notice] = "Expenses Unsubmitted"
          end
        else
          # If save fails, redisplay the form so user can fix problems
          format.html { redirect_to root_path }
          flash[:notice] = "Submit failed."
        end
      end
    end
  end

  #approvals

  def approvals
    @pages = Page.where(:department => current_user.department).order('date_of_time DESC')
    @new_pages = Page.new
    @users = User.where(:department => current_user.department)
  end


  def expensesapprovals
    @expenses = Expense.where(:department => current_user.department).order('date_activity DESC')
    @new_expenses = Expense.new

    @CUArray = current_user.pages.pluck(:credit_union).uniq
    @ExtraCUs = current_user.expenses.pluck(:credit_union).uniq
    @temp = @CUArray + @ExtraCUs
    @combinedCUs = (@temp - (@CUArray & @ExtraCUs))

    (@CUArray & @ExtraCUs).each { |x|  @combinedCUs.push(x) }

    @pages = current_user.pages.order('date_of_time DESC')
    @users = User.where(:department => current_user.department)

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
    params.require(:page).permit(:approval,:submitted)
  end

  def new_pages_params
    params.require(:page).permit(:credit_union, :activity, :task, :billing_options, :sun, :mon, :tue, :wed, :thu, :fri, :sat, :total, :date_of_time, :department, :sunnotes, :monnotes, :tuenotes, :wednotes, :thunotes, :frinotes, :satnotes, :submitted)
  end

  def params_final_expense
    new_pages_params_expense.merge(:user => current_user)
  end

  def new_pages_params_expense
    params.require(:expense).permit(:date_activity, :type_of_expense, :amount, :payment, :notes, :image, :credit_union, :meal_type)
  end




end
