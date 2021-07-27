class Film
  attr_reader :title, :director, :year

  def self.from_line(film_line)
    self.new(
      title: film_line[0],
      director: film_line[1],
      year: film_line[2]
    )
  end

  def initialize(params)
    @title = params[:title]
    @director = params[:director]
    @year = params[:year]
  end

  def to_s
    "#{@director} - \"#{@title}\" (#{@year})"
  end
end
