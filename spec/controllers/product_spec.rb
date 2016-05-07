require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  before(:all) do
    @product1 = Product.create(title: "Prod_1", description: "Desc_1", quantity: 1, price: 100)
  end

  it '#index' do
    get :index
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  it '#new' do
    get :new
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  it '#edit' do
    get :edit, id: @product1.id
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  describe '#create' do
  	before(:all) do
  		@product_params = {title: 'title', description: 'description'}
	  end
	  it 'create data' do
	  	expect{post :create, product: @product_params}.to change{Product.all.size}.by(1)
	  end
	  it 'redirect on success' do
	  	post :create, product: @product_params
	  	expect(response).not_to have_http_status(200)
	  	expect(response).to have_http_status(302) #重新導向
	  	expect(response).to redirect_to(admin_product_url(Product.last))
	  end
  	
  end


end
