class MoviePagesScenario < Scenario::Base
  uses :movie_helpers
  
  def load
    create_page "Movies",  :class_name => "MoviePage"
    
    create_movie "Debut", :description => "Her first appearance on screen.", :position => 1
    create_movie "Without url", :url => nil, :position => 2
    create_movie "Easter egg", :visible => false, :position => 3
    create_movie "Mostly harmless", :description => "Fourth in the trilogy", :position => 4
  end
  
end