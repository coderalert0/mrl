class BookmarksController < ApplicationController
  load_and_authorize_resource :speciality, find_by: :slug
  load_and_authorize_resource :program, find_by: :slug

  def create
    program_user = ProgramUser.find_or_create_by(program: @program, user: current_user)
    program_user.bookmark = program_user.bookmark.nil? ? true : !program_user.bookmark

    if program_user.save
      ahoy.track("Added/removed bookmark: #{@program.name} (#{@speciality.name})")

      flash.notice = "Bookmark #{program_user.bookmark? ? ' added' : 'removed'}"
    end

    redirect_to speciality_programs_path(@speciality)
  end
end
