require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def parent_klass
    controller_name.classify.constantize
  end

  def find_parent
    @parent = parent_klass.find(params[:id])
  end
end
