class WelcomeController < ApplicationController
  def index
   @users = User.includes(:campaigns).to_a
   @campaigns = if params[:tag]
                  Campaign.tagged_with(params[:tag]).to_a
                else
                  @campaigns = Campaign.all.to_a
                end
  end
   def about
   end
end
