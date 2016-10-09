class AddColumnToReview < ActiveRecord::Migration
  def change
     
    add_column :reviews, :cached_votes_up, :integer, :default => 0
    add_column :reviews, :cached_votes_down, :integer, :default => 0
    add_column :reviews, :cached_votes_score, :integer, :default => 0
    add_index  :reviews, :cached_votes_up
    add_index  :reviews, :cached_votes_down
    add_index  :reviews, :cached_votes_score
  end
end
