class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true}
      t.string :username, index: {unique: true}
      t.string :password_digest
      t.timestamps
    end
  end
end
