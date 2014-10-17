require 'spec_helper'

feature 'User has a conversation' do

  scenario 'with an existing contact' do
    user = create_and_sign_in
    create_new_contact_for(user)

    visit root_path
    within '.record-conversation' do
      click_on 'We spoke today'
    end
    within '.contact' do
      expect(page).to have_content('0 days ago')
    end
  end

end
