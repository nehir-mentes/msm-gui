class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def delete
    the_id = params.fetch("path_id")
    matching_rows = Actor.where({ :id => the_id })
    actor = matching_rows.at(0)

    actor.destroy

    redirect_to("/actors")
  end
  
  def insert
    i = Actor.new
    i.name = params.fetch("query_name")
    i.dob = params.fetch("query_dob")
    i.bio = params.fetch("query_bio")
    i.image = params.fetch("query_image")
    i.save

    redirect_to("/actors")

  end

  def update
    the_id = params.fetch("path_id")
    matching_rows = Actor.where({ :id => the_id })
    actor = matching_rows.at(0)

    # pull the new name out of the params
    actor.name = params.fetch("query_name")
    actor.dob = params.fetch("query_dob")
    actor.bio = params.fetch("query_bio")
    actor.image = params.fetch("query_image")

    # persist the change
    actor.save

    # send the user back to the contact’s show page
    redirect_to("/actors/#{actor.id}")
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
