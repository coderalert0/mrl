class DownloadProgramsController < ApplicationController
  include ProgramConcern

  load_and_authorize_resource :speciality, find_by: :slug
  before_action :authorize

  def index
    @programs = @speciality.programs

    respond_to do |format|
      format.html
      format.csv do
        ahoy.track("User downloaded csv: #{@speciality.name}")

        send_data to_csv(current_user), filename: "#{@speciality.name}-#{Date.today}.csv"
      end
    end
  end

  private

  def authorize
    return if current_user.paid?

    ahoy.track("User failed to download csv: #{@speciality.name}")

    flash[:alert] = 'You are not allowed to download the programs csv'
    redirect_to speciality_programs_path(@speciality)
  end

  def to_csv(user)
    attributes = %w[acgme_program_code name minimum_step_1_score step_2_required minimum_step_2_score
                    must_pass_step_2_cs_first_attempt j_1_sponsorship_through_ecfmg h1_b address
                    website program_director email program_coordinator program_coordinator_email phone]

    CSV.generate(headers: true) do |csv|
      csv << [t(:friendliness_score)].concat(attributes.map do |attribute|
        attribute.humanize.titleize
      end).concat(['Bookmarked'])

      matching_programs.each do |program|
        bookmarked = ProgramUser.where(program: program, user: user, bookmark: true).present?

        csv << [program.percentage(user.img_type)]
               .concat(attributes.map { |attr| program.send(attr) })
               .concat([bookmarked ? 'Yes' : 'No'])
      end
    end
  end
end
