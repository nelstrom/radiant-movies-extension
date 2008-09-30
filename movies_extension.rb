class MoviesExtension < Radiant::Extension
  version "0.1"
  description "Allows you to embed movies from YouTube or other video streaming sites."
  url "http://github.com/nelstrom/radiant-movies-extension"
  
  define_routes do |map|
    map.with_options(:controller => 'admin/movie') do |movie|
      movie.movie_index           'admin/movies',             :action => 'index'
      movie.movie_new             'admin/movies/new',         :action => 'new'
      movie.movie_edit            'admin/movies/edit/:id',    :action => 'edit'
      movie.movie_remove          'admin/movies/remove/:id',    :action => 'remove'
    end
  end
  
  def activate
    admin.tabs.add "Movies", "/admin/movies", :after => "Layouts", :visibility => [:all]
    Page.send :include, MovieTags
    MoviePage
  end
  
  def deactivate
    admin.tabs.remove "Movies"
  end
  
end