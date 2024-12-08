# class SearchesController < ApplicationController
#   before_action :authenticate_user!

#   def search
#     @range = params[:range]

#     if @range == "User"
#       @users = User.looks(params[:search], params[:word])
#     else
#       @posts = Post.looks(params[:search], params[:word])
#     end
#   end
# end

class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Post.search_for(@content, @method)
		end
	end
end