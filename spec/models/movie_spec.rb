require File.dirname(__FILE__) + '/../spec_helper'

# Test validation... (not!)
describe Movie, "with a movie page set" do
  scenario :movie_pages
  # test_helper :validations
  
  it "should use id and title to form a slug" do
    @movie = Movie.find_by_title("Debut")
    @movie.path.should == "/movies/#{@movie.id}-debut"
    @movie = Movie.find_by_title("Mostly harmless")
    @movie.path.should == "/movies/#{@movie.id}-mostly-harmless"
  end
end

describe Movie, "with no movie page set" do
  scenario :no_movie_page
  it "should not return a unique path" do
    @movie = Movie.find_by_title("Debut")
    @movie.path.should == nil
  end
end

describe Movie, "with many movie pages" do
  scenario :many_movie_pages
  it "should not return a unique path" do
    @movie = Movie.find_by_title("Debut")
    @movie.path.should == nil
  end
end