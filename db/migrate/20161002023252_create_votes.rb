class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :vote
      t.references :user, index: true, foreign_key: true
      t.references :review, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
