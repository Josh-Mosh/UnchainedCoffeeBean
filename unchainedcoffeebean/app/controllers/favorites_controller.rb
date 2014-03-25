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
	end
	redirect_to :back

  end

  def destroy
  	puts params
  	user = User.find(session[:user_id])
  	user.favorites.where("shop_id = #{params[:id]}").each do |favorite|
  		Favorite.destroy(favorite.id)
  	end
  	# Favorite.destroy(params[:id])
  	redirect_to :back
  end
end
