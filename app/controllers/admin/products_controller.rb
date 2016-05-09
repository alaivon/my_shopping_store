class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  def edit
    @photo = @product.photo || @product.build_photo
    # if @product.photo.present?
    #   @photo = @product.photo
    # else
    #   @photo = @product.build_photo
    # end
  end

  def create
    @product = Product.new(product_params)
      if @product.save
        redirect_to admin_product_url(@product), notice: 'Product was successfully created.'
      else
			  render :new 
      end

  end

  def update
		if @product.update(product_params)
    	redirect_to admin_product_url(@product), notice: 'Product was successfully created.'
    else
			render :edit
    end		
  end

  def destroy
   @product.destroy
   redirect_to admin_products_path
  end

  private



  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price,
                                    photo_attributes: [:image, :id])
  end

end
