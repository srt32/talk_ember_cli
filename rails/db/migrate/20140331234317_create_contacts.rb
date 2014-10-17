class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :user_id
      t.string :name
      t.integer :frequency

      t.timestamps
    end

    add_index(:contacts, :user_id)
  end

  def self.down
    drop_table :contacts
    remove_index(:contacts, :user_id)
  end
end
