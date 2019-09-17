Elasticsearch::Model.client = Elasticsearch::Client.new(
    user: ENV['elastic'],
    password: ENV['26082012']
)