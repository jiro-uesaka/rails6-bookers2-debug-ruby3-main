class RelationshipsController < ApplicationController
  
  def follow
    @users = User.find(params[:user_id])
    @users = @users.following
  end
  
  def follower
    @users = User.find(params[:user_id])
    @users = @users.followers
  end
  
  def create
    user = User.find(params[:user_id])
    relationship = Relationship.new(followed_id: user.id)
    relationship.follower_id = current_user.id
    relationship.save
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    relationship = Relationship.find_by(followed_id: user.id,follower_id: current_user.id)
    relationship.destroy
    redirect_to request.referer
  end
end
