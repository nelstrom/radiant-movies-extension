class MoviePagesScenario < Scenario::Base
  uses :movie_helpers
  
  def load
    create_page "Movies",  :class_name => "MoviePage"
    
    create_movie "Debut", :description => "Her first appearance on screen."
    create_movie "Without url", :url => nil
    create_movie "Easter egg", :visible => false
    create_movie "Mostly harmless", :description => "Fourth in the trilogy"
  end
  
end