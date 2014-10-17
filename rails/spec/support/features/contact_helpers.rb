module Features
  module ContactHelpers

    def create_new_contact_for(user)
      create(:contact, user: user)
    end

  end
end
