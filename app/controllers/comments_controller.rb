class CommentsController < ApplicationController
  before_action :find_commentable
  before_action :find_comment, only: [:destroy]
  after_action :publish_comment, only: [:create]

  respond_to :json

  authorize_resource

  def create
    @comment = @commentable.comments.create(comment_params.merge(user_id: current_user.id))
    render nothing: true
  end

  def destroy
    @comment.destroy
    render nothing: true
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def publish_comment
    PrivatePub.publish_to "/comments", comment: @comment.to_json
  end
end
