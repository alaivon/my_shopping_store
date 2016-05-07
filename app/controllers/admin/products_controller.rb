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
  end

  def edit
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
    @product = Product.update(product_params)
		if @product.save
    	redirect_to admin_product_url(@product), notice: 'Product was successfully created.'
    else
			render :new 
    end		
  end

  def destroy
   @product.destroy
   redirect_to admin_products_path
  end

  private

  def admin_required
    if !current_user.admin?
      redirect_to '/'
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

end
