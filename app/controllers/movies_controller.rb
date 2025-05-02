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
    i.save

    redirect_to("/movies")

  end

  def delete
    the_id = params.fetch("path_id")
    matching_rows = Movie.where({ :id => the_id })
    movie = matching_rows.at(0)

    movie.destroy

    redirect_to("/movies")
  end

  def update
    the_id = params.fetch("path_id")
    matching_rows = Movie.where({ :id => the_id })
    movie = matching_rows.at(0)

    # pull the new name out of the params
    movie.title = params.fetch("query_title")
    movie.year = params.fetch("query_year")
    movie.duration = params.fetch("query_duration")
    movie.description = params.fetch("query_description")
    movie.image = params.fetch("query_image")
    movie.director_id = params.fetch("query_director_id")

    # persist the change
    movie.save

    # send the user back to the contact’s show page
    redirect_to("/movies/#{movie.id}")
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
