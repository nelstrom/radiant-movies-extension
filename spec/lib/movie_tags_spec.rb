require File.dirname(__FILE__) + '/../spec_helper'

describe "Movie tags with no movie page" do
  scenario :no_movie_page_scenario
  it "should not find the url for the movies" do
    @page = pages(:home)
    @page.should render('<r:movies:each><r:title/></r:movies:each>').as('Debut')
    @page.should render('<r:movies:each><r:link/></r:movies:each>').as('You must have exactly 1 Movie page for this tag to work.')
  end
end

describe "Movie tags with more than one movie page" do
  scenario :many_movie_pages_scenario
  it "should not find the url for movies" do
    @page = pages(:home)
    @page.should render('<r:movies:each><r:title/></r:movies:each>').as('Debut')
    @page.should render('<r:movies:each><r:link/></r:movies:each>').as('You must have exactly 1 Movie page for this tag to work.')
  end
end

describe "Movie tags with one movie page" do
  scenario :movie_pages_scenario
  it "should render contents of r:movies" do
    @page = pages(:home)
    @page.should render('<r:movies>Whatever</r:movies>').as('Whatever')
  end
  it "should render contents of r:movies:each for each movie" do
    @page = pages(:home)
    @page.should render('<r:movies:each>a </r:movies:each>').as('a a a ')
  end
  it "should render title of each movie r:movies:each with r:movies:each:title" do
    @page = pages(:home)
    @page.should render('<r:movies:each><r:title/> </r:movies:each>').as('Debut Without url Mostly harmless ')
  end
  it "should render description of each movie r:movies:each with r:movies:each:description" do
    @page = pages(:home)
    @page.should render('<r:movies:each><p><r:description/></p></r:movies:each>').as('<p>Her first appearance on screen.</p><p>Description of your movie here</p><p>Fourth in the trilogy</p>')
  end
  it "should render position of each movie r:movies:each with r:movies:each:position" do
    @page = pages(:home)
    @page.should render('<r:movies:each><r:position/> </r:movies:each>').as('1 2 3 ')
  end
  it "should find the url for movies with r:link" do
    @page = pages(:home)
    movies = Movie.find(:all, :conditions => ["visible = ?", true])
    @page.should render('<r:movies:each><r:link/> </r:movies:each>').as(%Q{<a href=\"/movies/#{movies[0].id}-debut\" title=\"Debut\">Debut</a> <a href=\"/movies/#{movies[1].id}-without-url\" title=\"Without url\">Without url</a> <a href=\"/movies/#{movies[2].id}-mostly-harmless\" title=\"Mostly harmless\">Mostly harmless</a> })
  end
end