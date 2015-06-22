class ChangeVoteSizeToVoteSum < ActiveRecord::Migration
  def change
    remove_column :answers, :vote_size
    remove_column :questions, :vote_size
    remove_column :users, :vote_size
    add_column :answers, :vote_sum, :integer, default: 0
    add_column :questions, :vote_sum, :integer, default: 0
  end
end
