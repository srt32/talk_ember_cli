namespace :weekly do
  desc "Send mail summary to all users"
  task summary: :environment do
    User.includes(:contacts).all.each do |user|
      Mailer.weekly_summary(user).deliver
    end
  end
end
