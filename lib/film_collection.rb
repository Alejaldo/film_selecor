class FilmCollection
  def self.from_doc(doc)
    films = doc.map do |film_info|
      title = film_info.css("a").text
      director_draft = film_info.xpath("a/@title").text.split(",")[0]
      director = director_draft.slice(0..director_draft.index(" (")).strip
      year = film_info.css("span").text.delete("()")

      Film.from_line([title, director, year])
    end

    self.new(films)
  end
  
  def initialize(films = [])
    @films = films
  end

  def directors_list
    @films.map(&:director).uniq.sort
  end

  def by_selected_director(user_input)
    @films.select { |film| film.director == directors_list[user_input - 1] }
  end
end
