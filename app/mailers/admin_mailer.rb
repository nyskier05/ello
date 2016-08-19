class AdminMailer < ActionMailer::Base
  default from: 'ellonycmail@gmail.com'
  default to: 'ellonycmail@gmail.com'

  def new_user_waiting_for_approval(user)
    @user = user
    mail(subject: "New Signup: [#{@user.first_name} #{@user.last_name}, #{@user.email}]")
  end

  def new_user_approved(user)
    @user = user   
    mail(:to => @user.email, :subject => "ello signup approved!")
  end

end