json.extract! news, :id, :title, :body, :image, :campaign_id, :created_at, :updated_at
json.url news_url(comment, format: :json)
