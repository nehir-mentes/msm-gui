class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def insert
    i = Movie.new
    i.title = params.fetch("query_title")
    i.year = params.fetch("query_year")
    i.duration = params.fetch("query_duration")
    i.description = params.fetch("query_description")
    i.image = params.fetch("query_image")
    i.director_id = params.fetch("query_director_id")
    i.save

    redirect_to("/movies")

  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
