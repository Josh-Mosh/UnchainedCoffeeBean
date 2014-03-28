class ShopsController < ApplicationController
  layout "shop_layout"

  def new
    if !session[:user_id]
      flash[:adderror] = "You must be logged in to add new coffee shops"
      redirect_to :back
    else
      @shop = Shop.new
      render layout: "add_layout"
    end
  end

  def create
    shop = params[:shop]
    @user = User.find(session[:user_id])
    address = [shop[:number], shop[:street], shop[:city], shop[:state], shop[:zip], shop[:cntry]].compact.join(', ')
    @shop = @user.shops.create(shop_params)
    @address = Address.new(address: address)
    @shop.address = @address
    @shop.save
    if @shop.save
      flash[:success] = "Successfully Added New Shop"
      redirect_to "/"
    else
      flash[:errors] = @shop.errors.full_messages
      redirect_to "/shops/new"
    end
  end

  def edit
  end

  def update
  end

  def show
    @user = User.new
    @newcomment = Comment.new
    @favorite = Favorite.new
    @showshop = Shop.find(params[:id])

    gon.shopAddress = @showshop.address
    gon.shopInfo = @showshop

    @comments = Comment.all.where("shop_id = #{params[:id]}")
    render layout: "shop_layout"
  end

  def destroy
  end

  def near
    puts params
    @favorite = Favorite.new
    @allshops = Shop.all
    @shown_shops = []
    @user = User.new
    @allshops.each do |shop|
      if shop.address.latitude < params[:north].to_f and shop.address.latitude > params[:south].to_f and shop.address.longitude < params[:east].to_f and shop.address.longitude > params[:west].to_f
        @shown_shops.push(shop)
      end
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :street, :city, :state, :zip, :description, :website, :pricing, :address, :photo, :category_ids)
  end

  # def user_params
  #   params.require(:shop).permit(:name, :street, :city, :state, :zip, :description, :website, :pricing, :image, :address, :category_ids)
  # end
end
