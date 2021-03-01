class ApplicationController < ActionController::Base
  layout :layout_by_resource

  protect_from_forgery prepend: true, with: :exception

  before_action :set_paper_trail_whodunnit

  private

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
end
