require File.dirname(__FILE__) + '/../spec_helper'

# find movie page root by URL
# find virtual movie page by URL


  # test if_index/unless_index
  # test movie
  # test movie:title
  # test movie:description
  # test movie:url
  # test movie:path
# test movie:if_next
# test movie:if_previous
# test movie:next
# test movie:next/previous:title/description/url/path

describe MoviePage, "class find_by_url" do
  scenario :movie_pages
  it "should find the movie listings page at /movies" do
    Page.find_by_url('/movies').should == pages(:movies)
  end
  it "should find the virtual movie page at /movies/id-slug" do
    movie = Movie.find(:first, :conditions => ["visible = ?", true])
    Page.find_by_url("/movies/#{movie.to_param}").should == pages(:movies)
  end
  it "should be an index page at /movies" do
    Page.find_by_url('/movies').should render('<r:movies:if_index>YES!</r:movies:if_index>').as('YES!')
    Page.find_by_url('/movies').should render('<r:movies:unless_index>hidden</r:movies:unless_index>').as('')
  end
  it "should not be an index page at /movies/id-slug" do
    movie = Movie.find(:first, :conditions => ["visible = ?", true])
    Page.find_by_url("/movies/#{movie.to_param}").should render('<r:movies:if_index>hidden</r:movies:if_index>').as('')
    Page.find_by_url("/movies/#{movie.to_param}").should render('<r:movies:unless_index>YES!</r:movies:unless_index>').as('YES!')
  end
  
  it "should show contents of r:movie" do
    movie = Movie.find(:first, :conditions => ["visible = ?", true])
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie>hi!</r:movie>').as('hi!')
  end
  
  it "should show title with r:movie:title" do
    movie = Movie.find_by_title("Debut")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:title/></r:movie>').as('Debut')
  end
  
  it "should show description with r:movie:description" do
    movie = Movie.find_by_title("Debut")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:description/></r:movie>').as('Her first appearance on screen.')
  end
  
  it "should show url with r:movie:url" do
    movie = Movie.find_by_title("Debut")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:url/></r:movie>').as('linktoembedautubemovie')
  end
  
  it "should show path with r:movie:path" do
    movie = Movie.find_by_title("Debut")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:path/></r:movie>').as(movie.path)
  end
  
  it "should render contents of r:movie:if_next when movie has a successor" do
    movie = Movie.find_by_title("Debut")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:if_next>YES</r:if_next></r:movie>').as('YES')
  end
  
  it "should not render contents of r:movie:if_previous when movie has no predecessor" do
    movie = Movie.find_by_title("Debut")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:if_previous>hidden</r:if_previous></r:movie>').as('')
  end
  
  it "should not render contents of r:movie:if_next when movie has no successor" do
    movie = Movie.find_by_title("Mostly harmless")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:if_next>hidden</r:if_next></r:movie>').as('')
  end
  
  it "should render contents of r:movie:if_previous when movie has a predecessor" do
    movie = Movie.find_by_title("Mostly harmless")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:if_previous>YES</r:if_previous></r:movie>').as('YES')
  end
  
  it "should transfer context to next movie with movie:next" do
    movie, successor = Movie.find(:all, :conditions => ["visible = ?", true])
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:next><r:title/></r:next></r:movie>').as(successor.title)
    virtual_movie_page.should render('<r:movie><r:next><r:url/></r:next></r:movie>').as(successor.url)
  end
  
  it "should transfer context to previous movie with movie:previous" do
    movie, predecessor = Movie.find(:all, :conditions => ["visible = ?", true], :order => "id desc")
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:previous><r:title/></r:previous></r:movie>').as(predecessor.title)
    virtual_movie_page.should render('<r:movie><r:previous><r:url/></r:previous></r:movie>').as(predecessor.url)
  end
  
  
  it "should transfer context to next movie with movie:next, again" do
    movie, successor, sucsucsessor = Movie.find(:all, :conditions => ["visible = ?", true])
    virtual_movie_page = Page.find_by_url("/movies/#{movie.to_param}")
    virtual_movie_page.should render('<r:movie><r:next><r:next><r:title/></r:next></r:next></r:movie>').as(sucsucsessor.title)
    virtual_movie_page.should render('<r:movie><r:next><r:next><r:url/></r:next></r:next></r:movie>').as(sucsucsessor.url)
  end
  
end