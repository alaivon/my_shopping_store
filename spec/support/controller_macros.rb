module ControllerMacros
  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     sign_in FactoryGirl.create(:admin) # Using factory girl as an example
  #   end
  # end

  def login_user
    before(:each) do
      # @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
  end

  def login_user_without_admin
  before(:each) do
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    user_1 = User.create!(email: "example2@example.com", password: 1234567, password_confirmation: 1234567, is_admin: false)
    sign_in user_1
  end
end
end