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
      user = User.create!(email: "example1@example.com", password: 1234567, password_confirmation: 1234567, is_admin: true)
      sign_in user
    end
  end
end