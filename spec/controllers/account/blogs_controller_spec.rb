require 'rails_helper'

RSpec.describe Account::BlogsController, type: :controller do
  before do
    @user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name")
    @user1 = User.create!( :email => "test@example.com", :password => "12345678", :user_name => "test name")
    @blog_0 = Blog.first
  end

  describe "#edit" do
    describe "can go to edit page" do
      before do
        sign_in(@user)
      end
      it "has permission" do
        get :edit, params: { id: @blog_0[:id] }
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit)
      end
    end

    it "redirect_to sing_in page if not log in" do
      get :edit, params: { id: @blog_0[:id] }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user_session_path
    end

    describe "permission failed if not current_user" do
      before do
        sign_in(@user1)
      end
      it "no permission" do
        get :edit, params: { id: @blog_0[:id] }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to dashboard_path
      end
    end
  end

  describe "#update" do
    before do
      @blog_params = { :title => "Title", :description => "Description" }
      @blog1_params = { :title => "", :description => "Description" }
      sign_in(@user)
    end

    it "changes records" do
      post :update, params: { id: @blog_0.id, blog: @blog_params }
      expect(Blog.find(@blog_0[:id])[:title]).to eq("Title")
      expect(Blog.find(@blog_0[:id])[:description]).to eq("Description")
    end

    it "redirect on success" do
      post :update, params: { id: @blog_0.id, blog: @blog_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to dashboard_path
    end

    it "render :edit when title is empty" do
      post :update, params: { id: @blog_0.id, blog: @blog1_params }
      expect(response).not_to have_http_status(302)
      expect(Blog.find(@blog_0[:id])[:description]).not_to eq("Description")
      expect(response).to render_template(:edit)
    end

    it "redirect_to sing_in page if not log in" do
      sign_out(@user)
      post :update, params: { id: @blog_0.id, blog: @blog0_params }
      expect(Blog.find(@blog_0[:id])[:title]).not_to eq("Title")
      expect(response).to have_http_status(302)
      expect(response).to redirect_to user_session_path
    end
  end
end
