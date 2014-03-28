class CoffeeBeansController < ApplicationController
  layout 'coffee_beans_layout'

  def index
  	@user = User.new
  	if session[:user_id]
  		@current_user = User.find(session[:user_id])
  	end

  	@shops = Shop.all.limit(10)
  	@allshops = Shop.all
  	
  	gon.addresses = Address.all.where("addressable_type = 'Shop'")
  	
  	gon.shops = Shop.all.order("id")

  	@favorite = Favorite.new
  end

end
