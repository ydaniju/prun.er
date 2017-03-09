# frozen_string_literal: true
module LinkHandler
  def bool_check(stringy_bool)
    stringy_bool == 'true' ? true : false
  end

  def vanity_string
    link_params[:shortened_link]
  end

  def new_link_with_vanity_string?
    Link.where(shortened_link: vanity_string).blank?
  end

  def right_user
    @link = current_user.links.find_by(id: params[:id])
    redirect_to root_url if @link.nil?
  end

  def vanity_url_builder
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    @link.url_input = http_prefixer(@link.url_input)
    if @link.save
      if @link.update_attribute(:shortened_link, vanity_string)
        link_success_flash
      else
        link_failure_flash
      end
    end
  end

  def ordinary_url_builder
    @link = Link.new(link_params)
    @link.url_input = http_prefixer(@link.url_input)
    @link.user_id = current_user.id if signed_in?
    if @link.save
      link_success_flash
    else
      link_failure_flash
    end
    redirect_to root_path unless current_user
  end

  def link_failure_flash
    flash[:error] = 'An error occurred in creating link, please try again'
  end

  def link_success_flash
    flash[:link] = full_url(@link)
    flash[:success] = "Link successfully created #{flash[:link]}"
  end

  def http_prefixer(url)
    poor_url = url.split('www.').join
    return poor_url unless poor_url.split(':')[1].nil?
    "http://#{poor_url}"
  end

  def link_params
    params.require(:link).permit(:url_input, :shortened_link, :user_id)
  end

  def disabled_action
    flash[:error] = 'Link is disabled'
    redirect_to root_path
  end
end
