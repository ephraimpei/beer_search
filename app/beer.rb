class Beer
  attr_accessor :name, :image_url, :description

  def self.from_json(beer_json)
  	Beer.new.tap do |b|
  		b.name = beer_json["name"]
  		b.description = beer_json["description"]
  		b.image_url = beer_json["labels"]["medium"] if beer_json["labels"]

  		puts "empty beer here #{b.name}" if b.description.nil?
  	end
  end
end