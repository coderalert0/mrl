class SitemapController < ApplicationController
  skip_before_action :authenticate_user

  def show
    @programs = Program.all
  end
end
