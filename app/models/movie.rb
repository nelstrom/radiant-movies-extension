class Movie < ActiveRecord::Base
  validates_presence_of :url, :title
  
  def to_param
    [id, slug_from_title(title)].join("-")
  end
  
  def path
    movie_pages = Page.find_all_by_class_name("MoviePage")
    return nil unless movie_pages.size == 1
    movie_page = movie_pages.first
    path = [movie_page.url, to_param].join()
  end
  
  private
  
  def slug_from_title(title)
    title.downcase.split.join("-")
  end
  
end
