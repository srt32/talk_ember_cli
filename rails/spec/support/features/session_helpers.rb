module Features
  module SessionHelpers
    def create_and_sign_in(user=create(:user))
      visit sign_in_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      user
    end
  end
end
