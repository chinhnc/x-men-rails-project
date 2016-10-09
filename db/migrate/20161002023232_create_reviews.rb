class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :content
      t.float :rate
      t.references :user, index: true, foreign_key: true
      t.references :anime, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
