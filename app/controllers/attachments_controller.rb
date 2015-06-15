class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_attachment, only: [:destroy]

  def destroy
    @attachment.destroy
    render nothing: true
  end

  private

  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end
