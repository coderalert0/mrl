class SitemapController < ApplicationController
  skip_before_action :authenticate_user

  def show
    ahoy.track('Visitor accessed sitemap')

    @programs = Program.all
  end
end
