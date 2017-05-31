require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before do
    user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name")
    @blog_0 = Blog.first
    @post = Post.create!(title: "Title", description: "Description", user_id: user.id, blog_id: @blog_0.id)
  end

  describe "#show" do
    it "can go to show page" do
      get :show, params: { id: @post[:id] }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
end
