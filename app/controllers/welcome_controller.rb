class WelcomeController < ApplicationController
  def index
   @users = User.includes(:campaigns)
  end
   def show
   end
end
