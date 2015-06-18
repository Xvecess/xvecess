class ChangeUserVotesSize < ActiveRecord::Migration
  def change
    change_column :users, :vote_size, :integer, default: 0
  end
end
