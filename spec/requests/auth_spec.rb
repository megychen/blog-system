require 'rails_helper'

feature "register and login", :type => :feature do

  scenario "register" do
    visit "/users/sign_up"  # 浏览注册页面
    expect(page).to have_content("Sign up")

    within("#new_user") do  # 填表单
      fill_in("User name", with: "foobar name", :match => :prefer_exact)
      fill_in("Email", with: "foobar@example.com", :match => :prefer_exact)
      fill_in("Password", with: "12345678", :match => :prefer_exact)
      fill_in("Password confirmation", with: "12345678", :match => :prefer_exact)
    end

    click_button "Sign up"
    # 检查文字。这文字是 Devise 默认会放在 flash[:notice] 上的

    expect(page).to have_content("Welcome! You have signed up successfully")

    # 检查数据库里面最后一笔真的有刚刚填的资料

    user = User.last
    expect(user.email).to eq("foobar@example.com")

    blog = Blog.last
    expect(blog.title).to eq("foobar name's blog")
  end

  scenario "login and logout" do
    user = User.create!( :email => "foobar@example.com", :password => "12345678", :user_name => "foobar name")

    visit "/users/sign_in"

    within("#new_user") do
      fill_in "Email", with: "foobar@example.com"
      fill_in "Password", with: "12345678"
    end

    click_button "Log in"  # 点击登入按钮

    expect(page).to have_content("Signed in successfully")

    click_link "退出"  # 点击主选单的登出超连结
    expect(page).to have_content("Signed out successfully")
  end

end
