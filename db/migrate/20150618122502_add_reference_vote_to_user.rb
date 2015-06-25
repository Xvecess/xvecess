class AddReferenceVoteToUser < ActiveRecord::Migration
  def change
    add_reference :votes, :user, index: true
    add_column :votes, :votable_id, :integer
    add_column :votes, :votable_type, :string
    add_index :votes, [:votable_id, :votable_type]
  end
end
