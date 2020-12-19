module ApplicationHelper
  module BootstrapExtension
    def wizard_next_button
      submit_tag I18n.t(:next, scope: :registration), class: 'btn btn-primary'
    end
  end

  include BootstrapExtension
end
