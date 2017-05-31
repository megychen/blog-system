require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  before do
    user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name")
    @blog_0 = Blog.first
    #sign_in(user)
  end

  describe "#show" do
    it "can go to show page" do
      get :show, params: { id: @blog_0[:id] }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "#archives" do
    it "can go to archives page" do
      get :archives, params: { id: @blog_0[:id] }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:archives)
    end
  end

  describe "#about" do
    it "can go to about page" do
      get :about, params: { id: @blog_0[:id] }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:about)
    end
  end
end
