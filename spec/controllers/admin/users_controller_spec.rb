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
end
