class ChangeVotes < ActiveRecord::Migration
  def change
    remove_index :votes, [:votable_id, :votable_type]
    remove_column :votes, :votable_id
    remove_column :votes, :votable_type
  end
end
