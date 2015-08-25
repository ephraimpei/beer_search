require "net/http"

class Brewerydb
  @@base_uri = "http://api.brewerydb.com/v2/"

  def initialize(key)
  	raise "You need to provide an API key" if key.nil?
  	@key = key
  end

  def search(query)
  	endpoint = "search?"

  	options = {:key => @key, :type => "beer", :q => query, :format => "json"}

  	search_query = @@base_uri + endpoint + URI.encode_www_form(options).to_s
  	
  	return Net::HTTP.get_response(URI(search_query))
  	#self.class.get("http://api.brewerydb.com/v2", {:type=>"beer", :q=>query, :key=>@key, :format=>"json"})
  end
end
