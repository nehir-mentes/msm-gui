class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def insert
    i = Director.new
    i.name = params.fetch("query_name")
    i.dob = params.fetch("query_dob")
    i.bio = params.fetch("query_bio")
    i.image = params.fetch("query_image")
    i.save

    redirect_to("/directors")

  end

  def delete
    the_id = params.fetch("path_id")
    matching_rows = Director.where({ :id => the_id })
    director = matching_rows.at(0)

    director.destroy

    redirect_to("/directors")
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
