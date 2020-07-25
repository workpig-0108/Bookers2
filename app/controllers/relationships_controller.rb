class RelationshipsController < ApplicationController
	def show
		
	end

	def follow
		user = User.find(params[:id])
	  	current_user.follow(user)
	  	redirect_to user_path(user)
	end

	def unfollow
		user = User.find(params[:id])
		current_user.unfollow(user)
		redirect_to users_path
	end
end