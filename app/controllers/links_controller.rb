class LinksController < ApplicationController
  before_action :right_user, only: :destroy
  def index
  end

  def show
  end

  def create
    if signed_in?
      if new_link_with_vanity_string?
        vanity_url_builder
      else
        ordinary_url_builder
      end
      redirect_to current_user
    else
      ordinary_url_builder
    end
  end

  def destroy
    @link.destroy
    redirect_to root_path unless signed_in?
    flash[:success] = "Link successfully destroyed"
    redirect_to request.referrer || root_url
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    updated_params = params.require(:link).permit(:url_input, :enabled)
    target_url = http_prefixer(updated_params[:url_input])
    status = bool_check(updated_params[:enabled])
    current_link = Link.find(params[:id])
    if target_url == current_link.url_input && status == current_link.enabled
      flash[:alert] = "No changes made"
      redirect_to edit_path
    else
      current_link.update_attributes(url_input: target_url, enabled: status)
      flash[:success] = "Link updated"
      redirect_to current_user
    end
  end

  def redirector
    begin
      @link = Link.find_by_shortened_link(params[:path])
      raise NoMethodError if nil
      redirect_to @link.url_input, status: 301
      if @link.enabled
        @link.visits += 1
        @link.save
      end
    rescue
      flash[:error] = "Link must have been destroyed"
      redirect_to root_path
    end
  end
end
