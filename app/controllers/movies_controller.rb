class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      puts "PARAMS!!!:"
      puts params
      puts session.to_hash.keys
      if params.size == 2 and session.to_hash.size > 2
        redirect_to movies_path({ratings: session[:ratings],
        movie_title: session[:movie_title],
        release_date: session[:release_date]})
      else
        @all_ratings = Movie.all_ratings
        if params[:ratings].nil?
          @ratings_to_show = @all_ratings
        else
          @ratings_to_show = params[:ratings].keys
        end
        @movies = Movie.with_ratings(@ratings_to_show)
        selected_column_style = 'hilite p-3 mb-2 bg-warning text-primary'
        if params[:movie_title]
          @movies = @movies.order("title ASC")
          @movie_title_selected = selected_column_style
        end
        if params[:release_date]
          @movies = @movies.order("release_date ASC")
          @release_date_selected = selected_column_style
        end
        session[:ratings] = params[:ratings]
        session[:movie_title] = params[:movie_title]
        session[:release_date] = params[:release_date]
      end
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