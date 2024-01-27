class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
      t.string :frequency
      t.integer :times
      t.integer :successful, default: 0
      t.integer :unsuccessful, default: 0
      t.datetime :deadline
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end