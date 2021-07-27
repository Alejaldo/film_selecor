require "open-uri"
require "nokogiri"
require_relative "lib/film"
require_relative "lib/film_collection"

page = Nokogiri::HTML(URI.open("https://www.imdb.com/chart/top/?ref_=nv_mv_250").read)

FILM_FILE_NAME = "#{__dir__}/data/films.html"

File.write(FILM_FILE_NAME, page)

doc = Nokogiri::HTML(File.read(FILM_FILE_NAME)).css("td.titleColumn")

films = FilmCollection.from_doc(doc)

puts "App \"Film selector\""

films.directors_list.each.with_index(1) { |director, index| puts "#{index}. #{director}" }

puts "Select your favourite movie director"

user_input = nil

until (1..films.directors_list.length).include?(user_input)
  user_input = STDIN.gets.to_i
end

recommendations = films.by_selected_director(user_input)

puts recommendations.sample
