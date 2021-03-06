class PicturesController < ApplicationController

  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
    @most_recent_pictures = Picture.created_before(Date.today - 1.month)
  end

  def update
    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to "/pictures"
  end

  def load_picture
    @picture = Picture.find(params[:id])
  end

    def ensure_user_owns_picture
    unless current_user == @picture.user
      flash[:alert] = "Please log in"
      redirect_to new_session_url
    end
  end

  def show
   # @picture = Picture.find(params[:id])
  end

  def new
    @picture = Picture.new
  end

  # def edit
  #   @picture = Picture.find(params[:id])
  # end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id
    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to "/pictures"
      else
      # otherwise render new.html.erb
      render :new
    end
  end

    def update
    # @picture = Picture.find(params[:id])

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]


    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end


  def destroy
  @picture = Picture.find(params[:id])
  @picture.destroy
  redirect_to "/pictures"
  end

end
