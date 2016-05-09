require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  before(:all) do
    @product1 = create(:product)
  end
  login_user

  it '#index' do
  	get :index
  	expect(response).to have_http_status(200)
  end

  it '#to_normal' do
  	user = create(:user)
  	user.to_normal
  	post :to_normal, id: user.id
  	expect(user.is_admin).to eq(false)
  	expect(response).to have_http_status(302)
  	expect(response).to redirect_to(admin_users_url)
  end

  it '#to_admin' do
  	user1 = User.create(email: "test1@test.com", password: 1234567, password_confirmation: 1234567, is_admin: false)
  	user1.to_admin
  	post :to_admin, id: user1.id
  	expect(user1.is_admin).to eq(true)
  	expect(response).to have_http_status(302)
  	expect(response).to redirect_to(admin_users_url)
  end
end
