module LinksHelper
  def vanity_string
    link_params[:shortened_link]
  end

  def new_link_with_vanity_string?
    Link.where(shortened_link: vanity_string).blank?
  end

  def link_params
    params.require(:link).permit(:url_input, :shortened_link, :user_id)
  end

  def right_user
    @link = current_user.links.find_by(id: params[:id])
    redirect_to root_url if @link.nil?
  end

  def full_url(link)
    root_url + link.shortened_link.to_s
  end

  def new_link?
    Link.where(url_input: url_input).where(user_id: id).blank?
  end

  def vanity_url_builder
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    @link.url_input = http_prefixer(@link.url_input)
    if @link.save
      @link.update_attribute(:shortened_link, vanity_string)
      link_success_flash
    end
  end

  def ordinary_url_builder
    if signed_in?
      @link = Link.new(link_params)
      @link.user_id = current_user.id
      @link.url_input = http_prefixer(@link.url_input)
      @link.save
      link_success_flash
      redirect_to current_user
    else
      @link = Link.new(link_params)
      @link.url_input = http_prefixer(@link.url_input)
      @link.save
      link_success_flash
      redirect_to root_path
    end
  end

  def link_success_flash
    flash[:link] = full_url(@link)
    flash[:success] = "Link successfully created #{flash[:link]}"
  end

  def http_prefixer(url)
    poor_url = url.split("www.").join
    return poor_url unless poor_url.split(":")[1].nil?
    "http://#{poor_url}"
  end
end
