class Admin::MovieController < Admin::AbstractModelController
  model_class Movie
  
  # protected
  # 
  #   def model_index_url(params = {})
  #     send("#{ model_symbol }s_url", params)
  #   end
  # 
  #   def model_edit_url(params = {})
  #     send("edit_#{ model_symbol }_url", params)
  #   end
  
end

# class Admin::MoviesController < ApplicationController
#   def index
#     @movies = Movie.find :all
# 
#     respond_to do |format|
#       format.html # index.html.erb
#       format.xml  { render :xml => @movies }
#     end
#   end
# 
#   def show
#     @movie = Movie.find(params[:id])
# 
#     respond_to do |format|
#       format.html # show.html.erb
#       format.xml  { render :xml => @movie }
#     end
#   end
# 
#   def new
#     @movie = Movie.new
# 
#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @movie }
#     end
#   end
# 
#   def edit
#     @movie = Movie.find(params[:id])
#   end
# 
#   def create
#     @movie = Movie.new(params[:movie])
# 
#     respond_to do |format|
#       if @movie.save
#         flash[:notice] = 'Movie was successfully created.'
#         format.html { redirect_to(@movie) }
#         format.xml  { render :xml => @movie, :status => :created, :location => @movie }
#       else
#         format.html { render :action => "new" }
#         format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
#       end
#     end
#   end
# 
#   def update
#     @movie = Movie.find(params[:id])
# 
#     respond_to do |format|
#       if @movie.update_attributes(params[:movie])
#         flash[:notice] = 'Movie was successfully updated.'
#         format.html { redirect_to(@movie) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
#       end
#     end
#   end
# 
#   def destroy
#     @movie = Movie.find(params[:id])
#     @movie.destroy
# 
#     respond_to do |format|
#       format.html { redirect_to(admin_movies_url) }
#       format.xml  { head :ok }
#     end
#   end
# end
