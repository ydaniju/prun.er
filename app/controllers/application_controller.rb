# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHandler
  include SessionsHelper
  include LinkHandler

  def full_url(link)
    root_url + link.shortened_link.to_s
  end
end
