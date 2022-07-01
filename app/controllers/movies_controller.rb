class MoviesController < ApplicationController 
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, except: [:index, :new, :create]
  
  def index 
    @movies = Movie.send(movies_filter)
  end

  def new 
    @movie = Movie.new
  end

  def create 
    @movie = Movie.new(movie_params)

    if @movie.save 
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new 
    end
  end

  def show 
    @fans = @movie.fans 
    @genres = @movie.genres 
    
    if current_user 
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit 
  end

  def update 
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else 
      render :edit 
    end
  end

  def destroy 
    @movie.destroy 
    redirect_to movies_url, alert: "Movie successfully deleted!"
  end

  private 
  def set_movie 
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movie_params 
    params.require(:movie).permit(:title, :description, :rating, :total_gross, :released_on, :duration, :director, 
      :main_image, genre_ids: [])
  end

  def movies_filter
    if params[:filter].in? %w(upcoming recent hits flops)
      params[:filter]
    else
      :released
    end
  end
end