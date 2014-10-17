class Mailer < ActionMailer::Base
  default from: Clearance.configuration.mailer_sender

  def weekly_summary(user)
    @user = user
    @contacts = @user.contacts.sort_by(&:goal_percentage)

    mail(
      to: @user.email,
      subject: "Your weekly Stay In Touch summary",
    )
  end
end
