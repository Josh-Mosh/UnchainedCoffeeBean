class ShopsController < ApplicationController
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
    address = [shop[:street], shop[:city], shop[:state], shop[:zip]].compact.join(', ')
    # @shop = Shop.new(name: shop[:name], description: shop[:description], pricing: shop[:pricing], website: shop[:website], user_id: session[:user_id])
    @shop = @user.shops.create(shop_params)
    @address = Address.new(address: address)
    @shop.address = @address
    # @image = Image.create(photo_file_name: shop[:photo].original_filename, photo_content_type: shop[:photo].content_type)
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
    @showshop = Shop.find(params[:id])
    @comments = Comment.all.where("shop_id = #{params[:id]}")
    render layout: "shop_layout"
  end

  def destroy
  end

  
  private

  def shop_params
    params.require(:shop).permit(:name, :street, :city, :state, :zip, :description, :website, :pricing, :address, :photo, :category_ids)
  end

  # def user_params
  #   params.require(:shop).permit(:name, :street, :city, :state, :zip, :description, :website, :pricing, :image, :address, :category_ids)
  # end
end
