class AddDefaultValueForVoteValue < ActiveRecord::Migration
  def change
    remove_column :votes, :vote_value
    add_column :votes, :vote_value, :integer, default: 0
  end
end
