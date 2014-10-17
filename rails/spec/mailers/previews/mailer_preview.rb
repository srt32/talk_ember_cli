class MailerPreview < ActionMailer::Preview
  def weekly_summary
    Mailer.weekly_summary(User.last)
  end
end
