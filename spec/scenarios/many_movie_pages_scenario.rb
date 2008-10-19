class ManyMoviePagesScenario < Scenario::Base
  uses :movie_helpers
  
  def load
    create_page "Movies",  :class_name => "MoviePage"
    create_page "Videos",  :class_name => "MoviePage"
    
    create_movie "Debut", :description => "Her first appearance on screen.", :position => 1
  end
  
end