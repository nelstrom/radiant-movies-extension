module MovieTags
  include Radiant::Taggable
  
  desc %{The namespace for all movie tags}
  tag 'movies' do |tag|
    tag.expand
  end
  
  desc %{Returns all movies}
  tag 'movies:each' do |tag|
    movies = []
    tag.locals.movies = Movie.find(:all, :conditions => ["visible = ?", true], :order => "position ASC")
    tag.locals.movies.each do |movie|
      tag.locals.movie = movie
      movies << tag.expand
    end
    movies
  end
  
  [:title, :description, :url].each do |column|
    desc %{  Renders the `#{column}' attribute of the current movie.}
    tag "movies:each:#{column}" do |tag|
      tag.locals.movie[column]
    end
    desc %{  Renders contents unless the `#{column}' attribute is blank.}
    tag "movies:each:if_#{column}" do |tag|
      tag.expand unless tag.locals.movie[column].blank?
    end
  end
  
  desc %{Provides the position of the current movie in the list, starting at 1}
  tag 'movies:each:position' do |tag|
    tag.locals.movies.index(tag.locals.movie) + 1
  end
  
  
  desc %{
    Provides a link to the virtual page where this movie resides. 
    
    Note that this tag will only work if your site has one page of type MoviePage. 
    If you have more than one Movie Page, or no Movie Pages, then this tag won't work.
  }
  tag 'movies:each:link' do |tag|
    movie = tag.locals.movie
    if path = movie.path
      text = tag.double? ? tag.expand : movie.title
      %{<a href="#{path}" title="#{movie.title}">#{text}</a>}
    else
      "You must have exactly 1 Movie page for this tag to work."
    end
  end
  
  
end