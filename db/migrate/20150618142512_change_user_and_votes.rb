class ChangeUserAndVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :vote
    add_column :users, :vote_size, :integer
  end
end
