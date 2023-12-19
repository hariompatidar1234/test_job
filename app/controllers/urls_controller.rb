class UrlsController < ApplicationController


  def create
    @url = current_user.urls.new(url_params)
    @url.short_url =@url.generate_short_url
    @url.long_url = @url.sanitize
    if @url.save
     render json: @url, status: :created
    else
      render json: { errors: @url.errors.full_messages },
               status: :unprocessable_entity
    end
  end

  def show
    @url = Url.find_by_id( params[:id])
   render json: @url, status: :ok
  end

  def original_url
    if long_url.present?
        short_url = long_url
        redirect_to short_url_path
    end
  end

  private
  def url_params
    params.permit(:long_url,:short_url)
  end
end

