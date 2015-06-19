class AddVoteSize < ActiveRecord::Migration
  def change
    add_column :answers, :vote_size, :integer, default: 0
    add_column :questions, :vote_size, :integer, default: 0
    add_column :users, :vote_size, :integer, default: 0
  end
end
