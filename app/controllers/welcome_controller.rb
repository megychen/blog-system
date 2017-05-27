class WelcomeController < ApplicationController
  def index
    flash[:notice] = "This is flash message"
  end
end
