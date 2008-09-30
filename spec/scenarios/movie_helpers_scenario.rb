class MovieHelpersScenario < Scenario::Base
  uses :home_page
  
  helpers do
    def create_movie(title, attributes={})
      create_record :movie, title.symbolize, movie_params(attributes.reverse_merge(:title => title))
    end
    
    def movie_params(attributes={})
      title = attributes[:title] || unique_movie_title
      { 
        :title => title,
        :description => "Description of your movie here",
        :url => "linktoembedautubemovie",
        :visible => 1
      }.merge(attributes)
    end
    
    private
    
    @@unique_movie_name_call_count = 0
    def unique_movie_name
      @@unique_movie_name_call_count += 1
      "movie-#{@@unique_movie_name_call_count}"
    end
  end
end