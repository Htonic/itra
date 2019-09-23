require 'elasticsearch/model'

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    after_commit on: [:destroy] do
      begin
        __elasticsearch__.delete_document
      rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
        Rails.logger.warn(e)
      end
    end
    include Indexing
    after_touch() { __elasticsearch__.index_document }
  end
  module Indexing

    def as_indexed_json(options={})
      self.as_json(
          include: { news: { only: [:title,:body]},
                     comments:   { only: :opinion }
          })
    end
    def self.search(query)
      __elasticsearch__.search(
          {
              query: {
                  multi_match: {
                      query: query,
                      fields: ['name', 'description']
                  }
              },
              highlight: {
                  pre_tags: ['<em>'],
                  post_tags: ['</em>'],
                  fields: {
                      title: {},
                      text: {}
                  }
              }
          }
      )
    end
  end
end