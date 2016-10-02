class CreateAnimes < ActiveRecord::Migration[5.0]
  def change
    create_table :animes do |t|
      t.string :title
      t.string :description
      t.integer :episode
      t.string :image
      t.integer :status
      t.string :publish_year
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
