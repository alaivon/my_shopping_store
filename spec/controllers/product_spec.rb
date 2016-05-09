require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  before(:all) do
    # @product1 = Product.create(title: "Produ_1", description: "Desc_1", quantity: 1, price: 100)
    @product1 = create(:product)
  end
  login_user

  it "should have a current_user" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_user).to eq(User.last)
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

    it '#show' do
    get :show, id: @product1.id
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
  end

  describe '#create' do
    before(:all) do
      @product_params = {title: 'title', description: 'description', price: 1, quantity: 12}
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

    it 'render to new page' do
      allow_any_instance_of(Product).to receive(:save).and_return(false)
      post :create, product: @product_params
      expect(response).not_to have_http_status(302)
      expect(response).to render_template(:new)
      expect(response).to have_http_status(200) #重新導向
    end

  end

  describe '#update' do
    before(:all) do
      @product_params = {title: 'title3', description: 'description', price: 1, quantity: 1}
    end
    it 'update data' do
      post :update, product: @product_params, id: @product1.id
      expect(Product.find(@product1.id).title).to eq('title3')
    end

    it 'redirect on success after update' do
      post :update, product: @product_params, id: @product1.id
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(admin_product_url(@product1.id))
    end

    it 'render to edit page' do
      allow_any_instance_of(Product).to receive(:update).and_return(false)
      post :update, product: @product_params, id: @product1
      expect(response).not_to have_http_status(302)
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(200)
    end
  end

  describe '#destroy' do
    before(:each) do
      @product2 = @product1 || Product.create(title: "title1234", description: "Hello World", price: 1, quantity: 1)
    end
    it 'destroy data' do
      expect {delete :destroy, id: @product2.id}.to change{Product.all.count}.by(-1)
    end

    it 'render to index after destroy' do
      delete :destroy, id: @product2.id
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(admin_products_path)
    end
  end

  describe '#admin_required' do
    login_user_without_admin
    it 'redirect to root_url if not admin user' do
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_url)
    end
  end


end
