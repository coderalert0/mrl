class ApplicationController < ActionController::Base
  layout :layout_by_resource

  protect_from_forgery prepend: true, with: :exception

  before_action :redirect_from_heroku
  before_action :set_paper_trail_whodunnit
  before_action :authenticate_user

  private

  def redirect_from_heroku
    return unless request.host == 'myresidencylist.herokuapp.com'

    redirect_to("#{request.protocol}www.myresidencylist.com#{request.fullpath}", status: 301)
  end

  def layout_by_resource
    if devise_controller?
      'devise'
    elsif registration_controller?
      'landing'
    else
      'application'
    end
  end

  def registration_controller?
    controller_name == 'registration'
  end

  def session_controller?
    controller_name == 'sessions'
  end

  def authenticate_user
    return if registration_controller? || session_controller?

    redirect_to new_user_session_path unless user_signed_in?
  end
end
