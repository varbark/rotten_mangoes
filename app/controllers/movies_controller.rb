class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    if params[:title] || params[:director]
      @movies = Movie.search(params)
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
    render :new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "Movie creates successfully! "
    else
      render :new
    end

  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected
  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, 
      :runtime_in_minutes, :poster_image_url, 
      :description, :image
      )
  end
end
