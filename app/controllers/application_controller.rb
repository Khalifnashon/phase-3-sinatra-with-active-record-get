class ApplicationController < Sinatra::Base

  # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'

  get '/games' do
    # get all the games from the database
    games = Game.all.order(:title) 
    # Sorting the games by title

    # return a JSON response with an array of all the game data
    games.to_json
  end

  # use the :id syntax to create a dynamic route
  get '/games/:id' do
    # look up the game in the database using its ID
    game = Game.find(params[:id])

    # class Game < ActiveRecord::Base
    #   has_many :reviews
    #   has_many :users, through: :reviews
    # end

    # send a JSON-formatted response of the game data
    # include associated reviews in the JSON response
    # game.to_json(include: :reviews)

    # include user associated reviews in the JSON response
    # game.to_json(include: { reviews: { include: :user } })

    # We can also be more selective about which attributes are returned from 
    # each model with the only option:

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })

  end

end
