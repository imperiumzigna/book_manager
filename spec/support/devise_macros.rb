module DeviseMacros
  include Warden::Test::Helpers
  Warden.test_mode!

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin)
    end
  end
end
