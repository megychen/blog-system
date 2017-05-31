require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  before do
    @user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name")
  end

  describe "#index" do
    it "user loged in" do
      sign_in(@user)
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it "user is unauthenticated" do
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user_session_path
    end
  end
end
