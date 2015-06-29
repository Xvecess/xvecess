class CommentsController < ApplicationController
  before_action :find_commentable

  def create
    @comment = @commentable.comments.create(comment_params.merge(user_id: current_user.id))
    # PrivatePub.publish_to "/comments/#{@comment.commentable_id}/comment/", comment: @comment.to_json
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
