module ApplicationHelper
  module BootstrapExtension
    def wizard_next_button
      submit_tag 'View My Program Matches', class: 'btn btn-lg btn-success'
    end

    def wizard_show_matches_button
      submit_tag 'View My Program Matches', class: 'btn btn-success'
    end
  end

  include BootstrapExtension
end
