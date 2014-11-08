class CreateAddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string

    User.all.each do |user|
      user.update(token: SecureRandom.hex)
    end

    change_column_null :users, :token, false

    add_index :users, :token, unique: true
  end
end
