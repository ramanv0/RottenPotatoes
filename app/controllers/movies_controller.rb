class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @all_ratings = Movie.all_ratings
      if params.has_key?(:ratings)
        checked_ratings = params[:ratings]
      else
        checked_ratings = session[:ratings]
      end
      if params.has_key?(:movie_title)
        sort_by_title = params[:movie_title]
      else
        sort_by_title = session[:movie_title]
      end
      if params.has_key?(:release_date)
        sort_by_release = params[:release_date]
      else
        sort_by_release = session[:release_date]
      end
      if checked_ratings.nil?
        @ratings_to_show = @all_ratings
      else
        @ratings_to_show = checked_ratings.keys
      end
      @movies = Movie.with_ratings(@ratings_to_show)
      selected_column_style = 'hilite p-3 mb-2 bg-warning text-primary'
      if sort_by_title
        @movies = @movies.order("title ASC")
        @movie_title_selected = selected_column_style
      end
      if sort_by_release
        @movies = @movies.order("release_date ASC")
        @release_date_selected = selected_column_style
      end
      session[:ratings] = checked_ratings
      session[:movie_title] = sort_by_title
      session[:release_date] = sort_by_release
    end
  
    def new
      # default: render 'new' template
    end
  
    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end
  
    def edit
      @movie = Movie.find params[:id]
    end
  
    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end