class FavoritesController < ApplicationController
  def create

  	if session[:user_id]
	  	@user = User.find(session[:user_id])
  		@favorite = @user.favorites.create(shop_id: params[:favorite][:shop_id])	
  		if @favorite.save
  			flash[:success] = "Added to Favorites"
  		else
  			flash[:favoriteerror] = @favorite.errors.full_messages
  		end

      @activity = @user.activities.create(user_id: session[:user_id], shop_id: params[:favorite][:shop_id], type: "favorite")
      if @activity.save
        flash[:success] = "Added favorit activity"
      else
        flash[:activityerror] = @activity.errors.full_messages
      end

  	end
  end

  def destroy
  	puts "\n\n\n\n\n\n", params
  	user = User.find(session[:user_id])
  	user.favorites.where("shop_id = #{params[:favorite][:shop_id]}").each do |favorite|
  		Favorite.destroy(favorite.id)
  	end
  end
end
