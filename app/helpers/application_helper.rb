# frozen_string_literal: true
module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'for the finest of links'
    if page_title.empty?
      ' - ' + base_title
    else
      ' | ' + page_title + ' - ' + base_title
    end
  end

  def current_path
    request.env['PATH_INFO']
  end

  def url_format
    %r{(https?://)?([a-z0-9]+\\.)?[a-z0-9\\-]+\\.[a-z]+.+[^\\W\\_]}
  end
end
