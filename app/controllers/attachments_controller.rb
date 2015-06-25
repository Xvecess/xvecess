class AttachmentsController < ApplicationController
  before_action :find_attachment, only: [:destroy]

  def destroy
    if @attachment.attachable.user_id == current_user.id
      @attachment.destroy
      render nothing: true
    else
      redirect_to root_url, notice: 'Запрещено'
    end
  end

  private

  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end
