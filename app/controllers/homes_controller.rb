# frozen_string_literal: true
class HomesController < ApplicationController
  def index
    @display_top_links = Link.top_links
    @display_latest_links = Link.latest_links
    @display_top_users = User.top_users
    @link = signed_in? ? current_user.links.build : Link.new
  end
end
