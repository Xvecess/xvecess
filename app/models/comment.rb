class Comment < ActiveRecord::Base

  default_scope { order('created_at') }

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, :user_id, :commentable_id,
            :commentable_type, presence: true
end
