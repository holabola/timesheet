class PageMailer < ActionMailer::Base

    add_template_helper(PagesHelper)

    default from: "mail@example.com"

    def reminder_send(user,current)
      @user = user
      @current = current
      mail(to: "#{@user.email}", subject: "Your subject")
    end


  end
