require 'rails_helper'

RSpec.describe User, type: :model do
	before(:all) do
		@normal_user = User.create(email: "test@test.com", password: 1234567, password_confirmation: 1234567, is_admin: false)
	end
  # pending "add some examples to (or delete) #{__FILE__}"
  it '#to_normal' do
  	user = create(:user)
  	user.to_normal
  	expect(user.is_admin).to eq(false)
  	expect(user.is_admin).not_to eq(true)
  end

  it '#to_admin' do
  	@normal_user.to_admin
  	expect(@normal_user.is_admin).to eq(true)
  end
end
