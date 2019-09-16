class WelcomeController < ApplicationController
  def index
   @users = User.includes(:campaigns).to_a
   @campaigns = if params[:tag]
                  Campaign.tagged_with(params[:tag])
                else
                  @campaigns = Campaign.all
                end
  end
   def about
   end
end
