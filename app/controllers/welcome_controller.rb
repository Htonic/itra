class WelcomeController < ApplicationController
  def index
    @campaigns = if params[:tag]
      begin
        @campaigns = Campaign.tagged_with(params[:tag]).page(params[:page])
        @welcome = @campaigns
      rescue
        redirect_back(fallback_location: root_path)
      end
    else
      @welcome = Campaign.page(params[:page]).order(:updated_at).reverse_order
    end
  end
   def about
   end
  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def welcome_params
    params.permit(:tag, :page)
  end
end
