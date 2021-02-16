class BookmarksController < ApplicationController
  load_and_authorize_resource :speciality
  load_and_authorize_resource :program

  def create
    program_user = ProgramUser.where(program: @program, user: current_user).first

    if program_user
      program_user.update(bookmark: !program_user.bookmark)
    else
      program_user = ProgramUser.find_or_create_by(program: @program, user: current_user)
      program_user.update(bookmark: true)
    end

    redirect_to speciality_programs_path(@speciality)
  end
end
