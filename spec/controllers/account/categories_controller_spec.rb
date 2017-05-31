require 'rails_helper'

RSpec.describe Account::CategoriesController, type: :controller do
  before do
    @user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name")
    @user1 = User.create!( :email => "test@example.com", :password => "12345678", :user_name => "test name")
    @blog_0 = Blog.first
    @category = Category.create!( :name => "Category", :blog_id => @blog_0.id )
    sign_in(@user)
  end

  it "#index" do
    get :index, params: { id: @category, :blog_id => @blog_0.id }
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  describe "#create" do
    before do
      category = Category.new
      @category_params = { :name => "Category 1", :blog_id => @blog_0.id }
      @category_params1 = { :name => "", :blog_id => @blog_0.id }
    end

    it "creates records" do
      expect{ post :create, params: { category: @category_params, :blog_id => @blog_0.id }  }.to change{ Category.all.size }.by(1)
    end

    it "redirect on success" do
      post :create, params: { category: @category_params, :blog_id => @blog_0.id }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      redirect_to account_blog_categories_path
    end

    it "create failed when name is empty" do
      post :create, params: { category: @category_params, :blog_id => @blog_0.id }
      expect{ post :create, params: { category: @category_params1, :blog_id => @blog_0.id }  }.to change{ Category.all.size }.by(0)
    end

  end

  describe "#edit" do
    it "has permission" do
      get :edit, params: { id: @category[:id], :blog_id => @blog_0.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end

    describe "permission failed if not current_user" do
      before do
        sign_in(@user1)
      end
      it "no permission" do
        get :edit, params: { id: @category[:id], :blog_id => @blog_0.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to dashboard_path
      end
    end
  end

  describe "#update" do
    before do
      @category_params = { :name => "Category 1", :blog_id => @blog_0.id }
      @category_params1 = { :name => "", :blog_id => @blog_0.id }
    end

    it "changes records" do
      post :update, params: { id: @category.id, :blog_id => @blog_0.id, category: @category_params}
      expect(Category.find(@category[:id])[:name]).to eq("Category 1")
    end

    it "redirect on success" do
      post :update, params: { id: @category.id, :blog_id => @blog_0.id, category: @category_params }
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to account_blog_categories_path
    end

    it "render :edit when title is empty" do
      post :update, params: { id: @category.id, :blog_id => @blog_0.id, category: @category_params1 }
      expect(response).not_to have_http_status(302)
      expect(Category.find(@category[:id])[:name]).to eq("Category")
      expect(response).to render_template(:edit)
    end
  end

  describe "#destroy" do
    it "destroy record" do
      expect{ delete :destroy, params: { id: @category.id, :blog_id => @blog_0.id }  }.to change{ Category.all.size }.by(-1)
    end

    it "redirect on success after destroy" do
      delete :destroy, params: { id: @category.id, :blog_id => @blog_0.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to account_blog_categories_path
    end

    it "permission failed if not current_user" do
      sign_in(@user1)
      delete :destroy, params: { id: @category.id, :blog_id => @blog_0.id }
      expect{ delete :destroy, params: { id: @category.id, :blog_id => @blog_0.id }  }.to change{ Category.all.size }.by(0)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to dashboard_path
    end
  end

end
