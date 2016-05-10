ENV['FOOD2FORK_KEY'] = 'de8f2028d9a68d46c0da2909a47fefb4'

class Recipe < ActiveRecord::Base
  include HTTParty
  hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'
  base_uri "http://#{hostport}/api"
  default_params key: ENV['FOOD2FORK_KEY']
  format :json

  def self.for term
    get('/search', query: {q: term})['recipes']
  end
end
