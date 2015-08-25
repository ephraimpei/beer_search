require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'tilt/erb'
require 'json'
require_relative './app/brewerydb'
require_relative './app/beer'

set :root, File.dirname(__FILE__)
set :public_folder, File.join(File.dirname(__FILE__), 'public')

get '/' do
  File.read(File.join('views', 'index.erb'))
  @query = params[:q]
  search_for_beers(@query) if @query
  erb :index
end

def api
	@api ||= Brewerydb.new(ENV['BREWERYDB_API_KEY'])
end

def search_for_beers(q)
	response = api.search(q)
	
  if response.code == "200"
  	@beers = parse_beers(JSON.parse(response.body))
  else
  	@error = response.body
  end
end

def parse_beers(response)
	return [] unless response["data"]

	response["data"].map{|beer_json| Beer.from_json(beer_json)}
end