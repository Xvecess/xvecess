class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :best, :vote_sum

  has_many :comments
  has_many :attachments, serializer: AttachmentSerializer
end
