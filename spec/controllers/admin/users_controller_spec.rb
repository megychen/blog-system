require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  before do
    @user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name", :role => "admin")
    @user1 = User.create!( :email => "foobar1@example.com", :password => "12345678", :user_name => "foobar name1")
    @user2 = User.create!( :email => "foobar2@example.com", :password => "12345678", :user_name => "foobar name2")
    sign_in(@user)
  end

  describe "#index" do
    it "has permission" do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it "permission failed" do
      sign_in(@user1)
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end

    it "unauthenticated user" do
      sign_out(@user)
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user_session_path
    end
  end

  it "#show" do
    get :show, params: { id: @user.id }
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
  end

  describe "#destroy" do
    it "destroy record" do
      expect{ delete :destroy, params: { id: @user.id }  }.to change{ User.all.size }.by(-1)
    end

    it "permission failed" do
      sign_in(@user1)
      delete :destroy, params: { id: @user.id }
      expect{ delete :destroy, params: { id: @user.id }  }.to change{ User.all.size }.by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end

  describe "#set_admin" do
    it "change user role" do
      post :set_admin, params: { id: @user1.id }
      expect(response).to have_http_status(302)
      expect(User.find(@user1[:id])[:role]).to eq("admin")
      expect(response).to redirect_to admin_users_path
    end

    it "permission failed" do
      sign_in(@user1)
      post :set_admin, params: { id: @user2.id }
      expect(response).to have_http_status(302)
      expect(User.find(@user2[:id])[:role]).not_to eq("admin")
      expect(response).to redirect_to root_path
    end
  end
end
