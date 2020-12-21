class ProgramsController < ApplicationController
  load_and_authorize_resource :speciality
  load_and_authorize_resource :program

  def show; end

  def index
    @programs = Program.where(speciality: @speciality)
  end
end
