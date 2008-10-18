# Movies


  Created by: Andrew Neil
  Version: 1.0
  Contact: andrew.jr.neil AT gmail DOT com

This is an extension for Radiant CMS that allows you to manage movies from services such as youTube, Vimeo etc. It adds a 'Movies' tab to the Radiant admin, where you can create, edit or destroy movies. It also creates a MoviePage, which provides additional Radius tags making it easy to create a listings page of your movies. Each movie can be accessed at a virtual page, whose URL appears like a child page of the MoviePage

## Installation

This extension is hosted on github. If you have git installed, then `cd` to the root of your radiant project and issue this command:

    git clone git://github.com/nelstrom/radiant-movies-extension.git vendor/extensions/movies
  
If you don't have git, then you can instead download the tarball from this URL:

    http://github.com/nelstrom/radiant-movies-extension/tarball/master

and expand the contents to `your-radiant-project/vendor/extensions/movies`.

Once you have the extension added to your radiant project, you can run the rake task:

    rake (production) radiant:extensions:movies:install
    
    # this is equivalent to running the following two tasks:
    rake (production) radiant:extensions:movies:migrate
    rake radiant:extensions:movies:update

Restart your Radiant, and you should be good to go.

## Usage

### Movies tab

In the Radiant admin area, you should find an extra "Movies" tab. Click this to reveal a list of movies. You can add a new movie by clicking the "New movie" button. Existing movies can be edited by clicking on their title text, or removed from the system by clicking the "Remove" link. 

The following fields are available for movies:

* title - the title of the movie
* url - the code used to embed movies from youTube, Vimeo etc.
* description - you can enter a description
* status - can be set to visible or hidden. 

Services such as youTube, Vimeo etc. usually provide a snippet of code which you can copy and paste into any HTML document to embed the movie. This is code should be pasted directly, as is, into the URL field. 

### Movies page

When the movies extension is installed, a new page type called "Movie" becomes available. It is recommended that you create one page of this type. Each movie entered into the system should be visible in its own virtual page. These virtual pages look as though they are children of the movie page, but they don't exist in the sitemap. So if you have a sitemap like this: 

    Title             path      class
    -----             ----      -----
    Home              /         <normal>
      \_ About        /about    <normal>
      \_ Movies       /movies   Movie

and the following movies:

    id  Title                 status
    --  ------------------    ------
    1   Radiant Screencast    Visible
    2   Gitcast               Visible
    3   CakePHP Screencast    Hidden
    4   Railscast             Visible

Then the virtual pages for the movies would exist at the following paths:

    /movies/1-radiant-screencast
    /movies/2-gitcast
    /movies/4-railscast

The Movie page has a few additional Radius tags, to let you manipulate the movies in the system. Documentation for these tags can be accessed directly from within the Radiant page editing form, by clicking the 'Available tags' link. 

In particular, it is worth noting that tags referencing `movie` (as opposed to the plural `movies`) are intended to reference the movie of the current page, if it is a virtual page. 

The following example demonstrates a simple movie listings page:

    <r:movies:if_index>
    <ul id="movies">
      <r:movies:each>
        <li class="movie">
          <h2><r:link/></h2>
          <p><r:description/></p>
        </li>
      </r:movies:each>
    </ul>
    </r:movies:if_index>
  
    <r:movies:unless_index>
      <h2><r:movie:title/></h2>
    
      <div id="movie-wrapper">
        <r:movie:url/>
      </div>
    
      <div id="movie-description">
        <r:movie:description/>
      </div>
    </r:movies:unless_index>

### All pages

