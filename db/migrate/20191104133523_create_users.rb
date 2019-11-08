class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :user_type, default: 'user'
      t.string :password_digest

      t.timestamps
    end
  end
end
