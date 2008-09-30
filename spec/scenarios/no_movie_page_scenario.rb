class NoMoviePageScenario < Scenario::Base
  uses :movie_helpers
  
  def load
    create_movie "Debut", :description => "Her first appearance on screen."
  end
end