class RelationshipsController < ApplicationController
	def create
		#@relationship = Relationship.new(relationship_params)
		#@relationship.follower_id = current_user

		@user = User.find(relationship_params[:followed_id])

		if current_user.follow(@user)
			flash[:success] = "You are now following #{@user.email}"
		else
			flash[:danger] = "The user cannot be followed at this time"
		end

		redirect_to tweets_path

	end

	def relationship_params
		params.require(:relationship).permit(:followed_id)
	end
end
