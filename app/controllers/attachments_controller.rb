class AttachmentsController < ApplicationController
  before_action :find_attachment, only: [:destroy]

  authorize_resource
  def destroy
    authorize! :destroy, @attachment
    @attachment.destroy
    render nothing: true
  end

  private

  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end
