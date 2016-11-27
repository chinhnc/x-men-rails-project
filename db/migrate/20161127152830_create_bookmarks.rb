class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :anime, index: true, foreign_key: true

      t.timestamps
    end
  end
end
