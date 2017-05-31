require 'rails_helper'

RSpec.describe Account::PostsController, type: :controller do
  before do
    @user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name")
    @user1 = User.create!( :email => "test@example.com", :password => "12345678", :user_name => "test name")
    @blog_0 = Blog.first
    sign_in(@user)
    @post = Post.create!( title: "Title", description: "Description", user_id: @user.id, blog_id: @blog_0.id )
  end

  describe "#new" do
    it "can go to new page" do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end

    it "redirect_to sign in page if not login" do
      sign_out(@user)
      get :new
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user_session_path
    end
  end

  describe "#create" do
    before do
      post = Post.new
      @post_params = { :title => "Post1", :description => "Description1", user_id: @user, :blog_id => @blog_0.id }
      @post_params1 = { :title => "", :description => "Description1", user_id: @user, :blog_id => @blog_0.id }
    end

    it "creates records" do
      expect{ post :create, params: { post: @post_params }  }.to change{ Post.all.size }.by(1)
    end

    it "redirect on success" do
      post :create, params: { post: @post_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to dashboard_path
    end

    it "render :new when title is empty" do
      post :create, params: { post: @post_params1 }
      expect{ post :create, params: { post: @post_params1 }  }.to change{ Post.all.size }.by(0)
      expect(response).to render_template(:new)
    end

  end

  describe "#edit" do
    it "has permission" do
      get :edit, params: { id: @post[:id] }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end

    describe "permission failed if not current_user" do
      before do
        sign_in(@user1)
      end
      it "no permission" do
        get :edit, params: { id: @post[:id] }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to dashboard_path
      end
    end
  end

  describe "#update" do
    before do
      @post_params = { :title => "Title 0", :description => "Description 0" }
      @post_params1 = { :title => "", :description => "Description 1" }
    end

    it "changes records" do
      post :update, params: { id: @post.id, post: @post_params }
      expect(Post.find(@post[:id])[:title]).to eq("Title 0")
      expect(Post.find(@post[:id])[:description]).to eq("Description 0")
    end

    it "redirect on success" do
      post :update, params: { id: @post.id, post: @post_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to dashboard_path
    end

    it "render :edit when title is empty" do
      post :update, params: { id: @post.id, post: @post_params1 }
      expect(response).not_to have_http_status(302)
      expect(Post.find(@post[:id])[:description]).not_to eq("Description 1")
      expect(response).to render_template(:edit)
    end
  end

  describe "#destroy" do
    it "destroy record" do
      expect{ delete :destroy, params: { id: @post.id, format: ["application/json"] }  }.to change{ Post.all.size }.by(-1)
    end

    it "permission failed if not current_user" do
      sign_in(@user1)
      delete :destroy, params: { id: @post.id, format: ["application/json"] }
      expect{ delete :destroy, params: { id: @post.id, format: ["application/json"] }  }.to change{ Post.all.size }.by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to dashboard_path
    end
  end

  describe "#draft" do
    it "change post status" do
      post :draft, params: { id: @post.id }
      expect(response).to have_http_status(302)
      expect(Post.find(@post[:id])[:status]).to eq("draft")
      expect(response).to redirect_to dashboard_path
    end
  end

  describe "#publish" do
    it "change post status" do
      post :publish, params: { id: @post.id }
      expect(response).to have_http_status(302)
      expect(Post.find(@post[:id])[:status]).to eq("public")
      expect(response).to redirect_to dashboard_path
    end

    it "permission failed" do
      sign_in(@user1)
      post :publish, params: { id: @post.id }
      expect(response).to have_http_status(302)
      expect(Post.find(@post[:id])[:status]).not_to eq("publish")
      expect(response).to redirect_to dashboard_path
    end
  end

  describe "#hide" do
    it "change post status" do
      post :hide, params: { id: @post.id }
      expect(response).to have_http_status(302)
      expect(Post.find(@post[:id])[:status]).to eq("private")
      expect(response).to redirect_to dashboard_path
    end
  end

  it "permission failed" do
    sign_in(@user1)
    post :publish, params: { id: @post.id }
    expect(response).to have_http_status(302)
    expect(Post.find(@post[:id])[:status]).not_to eq("private")
    expect(response).to redirect_to dashboard_path
  end
end
