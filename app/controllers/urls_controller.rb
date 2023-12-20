class UrlsController < ApplicationController

  def create
    @url = current_user.urls.new(url_params)
    @url.short_url =@url.generate_short_url
    @url.long_url = @url.sanitize
    if @url.save
     render json: @url.short_url, status: :created
    else
      render json: { errors: @url.errors.full_messages },
               status: :unprocessable_entity
    end
  end

  def show
    @url = Url.find_by_id(params[:id])
   render json: @url, status: :ok
  end

  def shorten_and_verify
    short_url = params[:short_url]
    if short_url.present?
      existing_url = Url.find_by_short_url(short_url)
      if existing_url
        redirect_to existing_url.long_url

      else
        render json: { error: 'Invalid short URL' }, status: :unprocessable_entity
      end
    end
  end


  def update_shorten
    new_short = params[:update_short_url]
    short_url = params[:short_url]
    if new_short.present? && short_url.present?
      url = Url.find_by_short_url(short_url)
      if url
        url.short_url = new_short
        if url.save
          render json: { short_url: url.short_url, update_short_url: new_short }, status: :ok
        else
          render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'URL not found' }, status: :not_found
      end
    else
      render json: { error: 'Invalid short URL or missing parameters' }, status: :unprocessable_entity
    end
  end


  private


  def url_params
    params.permit(:long_url)
  end
end

