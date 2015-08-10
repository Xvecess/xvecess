class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :short_title, :vote_sum
  has_many :answers
  has_many :comments
  has_many :attachments, serializer: AttachmentSerializer

  def short_title
    object.title.truncate(10)
  end

  def vote_sum
    object.vote_sum.to_json
  end

end
