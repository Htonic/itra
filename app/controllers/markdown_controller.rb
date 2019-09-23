class MarkdownController < ApplicationController
  layout Markitup::Rails.configuration.layout
  def preview
    @text = params[:data]
  end
end