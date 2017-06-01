require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
  before do
    @user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name", :role => "admin")
    @user1 = User.create!( :email => "foobar1@example.com", :password => "12345678", :user_name => "foobar name1")
    @blog_0 = Blog.first
    sign_in(@user)
    @post = Post.create!( title: "Post", description: "Content", user_id: @user.id, blog_id: @blog_0.id )
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

  describe "#edit" do
    describe "can go to edit page" do
      it "has permission" do
        get :edit, params: { id: @post[:id] }
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit)
      end
    end

    it "permission failed" do
      sign_in(@user1)
      get :edit, params: { id: @post[:id] }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end

  describe "#update" do
    before do
      @post_params = { :title => "Title", :description => "Description" }
      @post1_params = { :title => "", :description => "Description" }
    end

    it "changes records" do
      post :update, params: { id: @post.id, post: @post_params }
      expect(Post.find(@post[:id])[:title]).to eq("Title")
      expect(Post.find(@post[:id])[:description]).to eq("Description")
    end

    it "redirect on success" do
      post :update, params: { id: @post.id, post: @post_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to admin_posts_path
    end

    it "render :edit when title is empty" do
      post :update, params: { id: @post.id, post: @post1_params }
      expect(response).not_to have_http_status(302)
      expect(Post.find(@post[:id])[:description]).not_to eq("Description")
      expect(response).to render_template(:edit)
    end

    it "permission failed" do
      sign_in(@user1)
      post :update, params: { id: @post.id, post: @post_params }
      expect(Post.find(@post[:id])[:title]).not_to eq("Title")
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end

  describe "#destroy" do
    it "destroy record" do
      expect{ delete :destroy, params: { id: @post.id }  }.to change{ Post.all.size }.by(-1)
    end

    it "permission failed" do
      sign_in(@user1)
      delete :destroy, params: { id: @post.id }
      expect{ delete :destroy, params: { id: @post.id }  }.to change{ Post.all.size }.by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end
end
