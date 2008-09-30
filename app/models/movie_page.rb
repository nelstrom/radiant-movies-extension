class MoviePage < Page
  description "Provides tags and behavior to support searching Radiant.  Based on Oliver Baltzer's search_behavior."
  
  # Allows URLs to direct to the virtual course listing subpage
  def find_by_url(url, live = true, clean = false)
    url = clean_url(url) if clean
    if url =~ %r{#{self.url}(\d+)}
      begin
        @movie = Movie.find($1)
        self
      rescue
        super
      end
    else
      self
    end
  end
  
  
  desc %{    
    Usage:
    <pre><code><r:movies:if_index>...</r:movies:if_index></code></pre> }
  tag "movies:if_index" do |tag|
    unless @movie
      tag.expand
    end
  end
  
  desc %{    
    Usage:
    <pre><code><r:movies:unless_index>...</r:movies:unless_index></code></pre> }
  tag "movies:unless_index" do |tag|
    if @movie
      tag.expand
    end
  end
  
  desc %{The namespace for an individual movie}
  tag "movie" do |tag|
    tag.locals.movie = @movie
    tag.expand
  end
  
  desc %{Renders the title of the current movie}
  tag "movie:title" do |tag|
    tag.locals.movie.title
  end
  
  desc %{Renders the tag contents only if the description is not blank}
  tag "movie:if_description" do |tag|
    tag.expand unless tag.locals.movie.description.blank?
  end
  
  desc %{Renders the tag contents only if the description is blank}
  tag "movie:unless_description" do |tag|
    tag.expand if tag.locals.movie.description.blank?
  end
  
  desc %{Renders the description of the current movie}
  tag "movie:description" do |tag|
    tag.locals.movie.description
  end
  
  desc %{Outputs the embed code for the current movie}
  tag "movie:url" do |tag|
    tag.locals.movie.url
  end
  
  desc %{Shows the path for this movie}
  tag 'movie:path' do |tag|
    tag.locals.movie.path
  end
  
  
  desc %{The contents of this tag are rendered only if this movie has a successor}
  tag "movie:if_next" do |tag|
    tag.locals.next_movie = Movie.find(:first, :conditions => ["id > ? AND visible = ?", tag.locals.movie.id, true])
    tag.expand if tag.locals.next_movie
  end
  
  desc %{The contents of this tag are rendered only if this movie has a predecessor}
  tag "movie:if_previous" do |tag|
    tag.locals.previous_movie = Movie.find(:first, :conditions => ["id < ? AND visible = ?", tag.locals.movie.id, true], :order => 'id desc')
    tag.expand if tag.locals.previous_movie
  end
  
  desc %{Transfers the context to the next movie}
  tag "movie:next" do |tag|
    if next_movie = Movie.find(:first, :conditions => ["id > ? AND visible = ?", tag.locals.movie.id, true])
      tag.locals.movie = next_movie
      tag.expand
    end
  end
  
  desc %{Transfers the context to the previous movie}
  tag "movie:previous" do |tag|
    if previous_movie = Movie.find(:first, :conditions => ["id < ? AND visible = ?", tag.locals.movie.id, true], :order => 'id desc')
      tag.locals.movie = previous_movie
      tag.expand
    end
  end
  
end