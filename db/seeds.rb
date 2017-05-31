# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(:user_name => "megychen", :email => "megy.chen203@gmail.com", :password => "12345678", :password_confirmation => "12345678")
User.create!(:user_name => "andychai", :email => "andy@gmail.com", :password => "12345678", :password_confirmation => "12345678")
User.create!(:user_name => "millyguo", :email => "milly@gmail.com", :password => "12345678", :password_confirmation => "12345678")
User.create!(:user_name => "lilycui", :email => "lily@gmail.com", :password => "12345678", :password_confirmation => "12345678")

Post.create!( :title => "Post One", :description => "This is my first post", blog_id: 1, user_id: 1 )
Post.create!( :title => "Post Two", :description => "This is my second post", blog_id: 2, user_id: 2 )
Post.create!( :title => "Post Three", :description => "This is my third post", blog_id: 3, user_id: 3 )
Post.create!( :title => "Post Four", :description => "This is my forth post", blog_id: 4, user_id: 4 )

Category.create!( :name => "Category one", blog_id: 1 )
Category.create!( :name => "Category Two", blog_id: 2 )
Category.create!( :name => "Category Three", blog_id: 3 )
Category.create!( :name => "Category Four", blog_id: 4 )
